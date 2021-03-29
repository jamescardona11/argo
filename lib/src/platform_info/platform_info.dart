import 'platform_locator.dart' if (dart.library.io) 'platform_io.dart';

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

enum PlatformInfoType {
  Web,
  Windows,
  Linux,
  MacOS,
  Android,
  Fuchsia,
  IOS,
}