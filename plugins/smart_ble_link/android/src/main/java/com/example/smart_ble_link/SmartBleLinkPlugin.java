package com.example.smart_ble_link;

import android.Manifest;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.wifi.WifiInfo;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.PowerManager;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import com.hiflying.blelink.LinkerUtils;
import com.hiflying.blelink.LinkedModule;
import com.hiflying.blelink.LinkingError;
import com.hiflying.blelink.LinkingProgress;
import com.hiflying.blelink.OnLinkListener;
import com.hiflying.blelink.v1.BleLinker;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class SmartBleLinkPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler,
        EventChannel.StreamHandler, ActivityAware, OnLinkListener,
        PluginRegistry.RequestPermissionsResultListener {

    private static final int REQUEST_PERMISSIONS = 4002;
    private static boolean sdkInitialized = false;

    private Context applicationContext;
    private Activity activity;
    private ActivityPluginBinding activityBinding;
    private MethodChannel methodChannel;
    private EventChannel.EventSink eventSink;
    private final Handler mainHandler = new Handler(Looper.getMainLooper());
    private BleLinker bleLinker;
    private MethodChannel.Result pendingPermissionResult;
    private PowerManager.WakeLock wakeLock;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        applicationContext = binding.getApplicationContext();
        methodChannel = new MethodChannel(binding.getBinaryMessenger(), "smart_ble_link/method");
        methodChannel.setMethodCallHandler(this);
        new EventChannel(binding.getBinaryMessenger(), "smart_ble_link/events").setStreamHandler(this);

        bleLinker = BleLinker.getInstance(applicationContext);
        if (!sdkInitialized) {
            bleLinker.init();
            sdkInitialized = true;
        }
        bleLinker.setOnLinkListener(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
        eventSink = null;
        bleLinker.setOnLinkListener(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activityBinding = binding;
        activity = binding.getActivity();
        binding.addRequestPermissionsResultListener(this);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        if (activityBinding != null) {
            activityBinding.removeRequestPermissionsResultListener(this);
        }
        activityBinding = null;
        activity = null;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "startLinking":
                handleStartLinking(call, result);
                break;
            case "stopLinking":
                bleLinker.stop();
                releaseWakeLock();
                result.success(null);
                break;
            case "isBluetoothEnabled":
                result.success(bleLinker.isBluetoothAdapterEnabled());
                break;
            case "isBleSupported":
                result.success(bleLinker.isBleSupported());
                break;
            case "requestEnableBluetooth":
                handleRequestEnableBluetooth(result);
                break;
            case "requestPermissions":
                handleRequestPermissions(result);
                break;
            case "getConnectedSsid":
                result.success(currentSsid());
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void handleStartLinking(MethodCall call, MethodChannel.Result result) {
        String ssid = call.argument("ssid");
        String password = call.argument("password");
        String bleName = call.argument("bleName");
        String userData = call.argument("userData");
        Integer timeoutSeconds = call.argument("timeoutSeconds");
        Boolean strictMatching = call.argument("bleNameStrictMatching");

        if (ssid == null || ssid.trim().isEmpty()) {
            ssid = currentSsid();
        }
        if (ssid == null || ssid.trim().isEmpty() || "<unknown ssid>".equals(ssid)) {
            result.error("INVALID_ARGUMENT", "ssid is empty and cannot be detected", null);
            return;
        }

        bleLinker.setSsid(ssid);
        bleLinker.setPassword(password == null ? "" : password);
        bleLinker.setBleName(bleName == null || bleName.trim().isEmpty() ? "AZ" : bleName);
        bleLinker.setUserData(userData == null ? "" : userData);
        bleLinker.setDeviceFindingType(BleLinker.DEVICE_FOUNDING_TYPE_UDP_BLE);
        bleLinker.setTimeoutPeriod(timeoutSeconds == null || timeoutSeconds <= 0
                ? 60000 : timeoutSeconds * 1000);
        bleLinker.setBleNameStrictMatching(strictMatching == null || strictMatching);

        try {
            acquireWakeLock();
            bleLinker.start();
            result.success(null);
        } catch (Exception e) {
            releaseWakeLock();
            result.error("START_FAILED", e.getMessage(), null);
        }
    }

    private void handleRequestEnableBluetooth(MethodChannel.Result result) {
        if (activity == null) {
            result.error("NO_ACTIVITY", "activity is not attached", null);
            return;
        }
        Intent intent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
        activity.startActivityForResult(intent, 4001);
        result.success(null);
    }

    private void handleRequestPermissions(MethodChannel.Result result) {
        if (activity == null) {
            result.error("NO_ACTIVITY", "activity is not attached", null);
            return;
        }
        List<String> permissions = new ArrayList<>();
        if (Build.VERSION.SDK_INT >= 31) {
            permissions.add(Manifest.permission.BLUETOOTH_SCAN);
            permissions.add(Manifest.permission.BLUETOOTH_CONNECT);
        }
        permissions.add(Manifest.permission.ACCESS_FINE_LOCATION);
        pendingPermissionResult = result;
        ActivityCompat.requestPermissions(activity,
                permissions.toArray(new String[0]), REQUEST_PERMISSIONS);
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions,
            int[] grantResults) {
        if (requestCode != REQUEST_PERMISSIONS || pendingPermissionResult == null) {
            return false;
        }
        boolean allGranted = true;
        for (int grantResult : grantResults) {
            if (grantResult != PackageManager.PERMISSION_GRANTED) {
                allGranted = false;
                break;
            }
        }
        pendingPermissionResult.success(allGranted);
        pendingPermissionResult = null;
        return true;
    }

    private String currentSsid() {
        WifiInfo wifiInfo = bleLinker.getConnectedWifi();
        if (wifiInfo == null) {
            return null;
        }
        String ssid = LinkerUtils.getPureSsid(wifiInfo.getSSID());
        if (ssid == null || ssid.isEmpty() || "<unknown ssid>".equals(ssid)) {
            return null;
        }
        return ssid;
    }

    private void send(final Map<String, Object> event) {
        if (eventSink == null) {
            return;
        }
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                eventSink.success(event);
            }
        });
    }

    private void acquireWakeLock() {
        if (activity != null) {
            activity.runOnUiThread(() -> activity.getWindow().addFlags(
                    WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON));
        }
        if (wakeLock == null && applicationContext != null) {
            PowerManager pm = (PowerManager) applicationContext.getSystemService(Context.POWER_SERVICE);
            wakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "smart_ble_link:linking");
        }
        if (wakeLock != null && !wakeLock.isHeld()) {
            wakeLock.acquire(120000);
        }
    }

    private void releaseWakeLock() {
        if (wakeLock != null && wakeLock.isHeld()) {
            wakeLock.release();
        }
        if (activity != null) {
            activity.runOnUiThread(() -> activity.getWindow().clearFlags(
                    WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON));
        }
    }

    @Override
    public void onWifiConnectivityChanged(boolean connected, String ssid, WifiInfo wifiInfo) {
        Map<String, Object> event = new HashMap<>();
        event.put("event", "wifi");
        event.put("connected", connected);
        event.put("ssid", ssid);
        send(event);
    }

    @Override
    public void onBluetoothEnabledChanged(boolean enabled) {
        Map<String, Object> event = new HashMap<>();
        event.put("event", "bluetooth");
        event.put("enabled", enabled);
        send(event);
    }

    @Override
    public void onModuleLinked(LinkedModule module) {
        Map<String, Object> event = new HashMap<>();
        event.put("event", "linked");
        event.put("mac", module.getMac());
        event.put("ip", module.getIp());
        event.put("id", module.getId());
        send(event);
    }

    @Override
    public void onModuleLinkTimeOut() {
        Map<String, Object> event = new HashMap<>();
        event.put("event", "timeout");
        send(event);
    }

    @Override
    public void onFinished() {
        releaseWakeLock();
        Map<String, Object> event = new HashMap<>();
        event.put("event", "finished");
        send(event);
    }

    @Override
    public void onError(LinkingError error) {
        Map<String, Object> event = new HashMap<>();
        event.put("event", "error");
        event.put("code", error.name());
        send(event);
    }

    @Override
    public void onProgress(LinkingProgress progress) {
        Map<String, Object> event = new HashMap<>();
        event.put("event", "progress");
        event.put("progress", progress.name());
        send(event);
    }
}
