import 'platform_locator.dart' if (dart.library.io) 'platform_io.dart';

// ignore: avoid_classes_with_only_static_members
/// {@template platform_info}
///
/// Class to know in what type of plataform is launched.
/// Use `if` in the import to know if the app is launch in the web or in another plataform
///
/// {@endtemplate}

abstract class PlatformInfo {
  static PlatformInfoType get value => currentPlatformInfo;

  static bool get isWeb => currentPlatformInfo == PlatformInfoType.Web;
  static bool get isMacOS => currentPlatformInfo == PlatformInfoType.MacOS;
  static bool get isWindows => currentPlatformInfo == PlatformInfoType.Windows;
  static bool get isLinux => currentPlatformInfo == PlatformInfoType.Linux;
  static bool get isAndroid => currentPlatformInfo == PlatformInfoType.Android;
  static bool get isIOS => currentPlatformInfo == PlatformInfoType.IOS;
  static bool get isFuchsia => currentPlatformInfo == PlatformInfoType.Fuchsia;
}

/// All types of plataforms that supports `Flutter`
enum PlatformInfoType {
  Web,
  Windows,
  Linux,
  MacOS,
  Android,
  Fuchsia,
  IOS,
}
