import 'package:permission_handler/permission_handler.dart';

/// 위치 권한을 확인, 권한이 없을 경우 권한 요청,
/// 권한 부여를 거부하거나 이미 거부되어 있는경우 return false
/// 권한을 성공벅으로 부여되었다면 return true
Future<bool> getLocationPermission() async {
  final locationStatus = await Permission.location.status;
  // print('Current Location Status : ${locationStatus.isGranted}');

  // 위치 권한 success 일시
  if (locationStatus.isGranted) {
    return true;
  }

  // 위치 권한 없을시 권한 요청, 권한 수락 하면 return true
  if (await Permission.location.request().isGranted) {
    return true;
  }

  // print('권한 영구 거부 ${locationStatus.isPermanentlyDenied}');
  return false;
}
