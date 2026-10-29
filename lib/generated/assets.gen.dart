// dart format width=100

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/empty.png
  AssetGenImage get empty => const AssetGenImage('assets/icon/empty.png');

  /// File path: assets/icon/ic_launcher.png
  AssetGenImage get icLauncher => const AssetGenImage('assets/icon/ic_launcher.png');

  /// File path: assets/icon/offline.png
  AssetGenImage get offline => const AssetGenImage('assets/icon/offline.png');

  /// List of all assets
  List<AssetGenImage> get values => [empty, icLauncher, offline];
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/blue.json
  String get blue => 'assets/json/blue.json';

  /// File path: assets/json/green.json
  String get green => 'assets/json/green.json';

  /// File path: assets/json/red.json
  String get red => 'assets/json/red.json';

  /// File path: assets/json/theme.json
  String get theme => 'assets/json/theme.json';

  /// List of all assets
  List<String> get values => [blue, green, red, theme];
}

class $AssetsLaunchGen {
  const $AssetsLaunchGen();

  /// File path: assets/launch/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/launch/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

abstract final class Assets {
  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
  static const $AssetsLaunchGen launch = $AssetsLaunchGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}, this.animation});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
