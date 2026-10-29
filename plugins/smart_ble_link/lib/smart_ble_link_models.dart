class SmartLinkEvent {
  const SmartLinkEvent({
    required this.event,
    this.enabled,
    this.connected,
    this.ssid,
    this.text,
    this.progress,
    this.mac,
    this.ip,
    this.id,
    this.errorCode,
    this.errorMessage,
  });

  factory SmartLinkEvent.fromMap(Map<String, dynamic> map) {
    return SmartLinkEvent(
      event: map['event'] as String,
      enabled: map['enabled'] as bool?,
      connected: map['connected'] as bool?,
      ssid: map['ssid'] as String?,
      text: map['text'] as String?,
      progress: map['progress'] as String?,
      mac: map['mac'] as String?,
      ip: map['ip'] as String?,
      id: map['id'] as String?,
      errorCode: map['code'] as String?,
      errorMessage: map['message'] as String?,
    );
  }

  final String event;
  final bool? enabled;
  final bool? connected;
  final String? ssid;
  final String? text;
  final String? progress;
  final String? mac;
  final String? ip;
  final String? id;
  final String? errorCode;
  final String? errorMessage;

  bool get isBluetooth => event == 'bluetooth';
  bool get isWifi => event == 'wifi';
  bool get isMessage => event == 'message';
  bool get isProgress => event == 'progress';
  bool get isLinked => event == 'linked';
  bool get isTimeout => event == 'timeout';
  bool get isError => event == 'error';
  bool get isFinished => event == 'finished';

  @override
  String toString() =>
      'SmartLinkEvent(event: $event, enabled: $enabled, connected: $connected, '
      'ssid: $ssid, text: $text, progress: $progress, mac: $mac, ip: $ip, '
      'id: $id, errorCode: $errorCode, errorMessage: $errorMessage)';
}
