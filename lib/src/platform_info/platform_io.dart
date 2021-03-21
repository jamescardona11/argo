import 'dart:io';
import 'platform_info.dart';

PlatformInfoType get currentPlatformInfo {
  if (Platform.isWindows) return PlatformInfoType.Windows;
  if (Platform.isFuchsia) return PlatformInfoType.Fuchsia;
  if (Platform.isMacOS) return PlatformInfoType.MacOS;
  if (Platform.isLinux) return PlatformInfoType.Linux;
  if (Platform.isIOS) return PlatformInfoType.IOS;
  return PlatformInfoType.Android;
}
