import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hycharge/providers/is_dark_mode.dart';
import 'package:hycharge/utils/location_permission.dart';
import 'package:hycharge/utils/open_app_setting.dart';
import 'package:provider/provider.dart';

class ChargerFind extends StatefulWidget {
  const ChargerFind({super.key});

  @override
  State<ChargerFind> createState() => _ChargerFindState();
}

class _ChargerFindState extends State<ChargerFind> {
  @override
  Widget build(BuildContext context) {
    // final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // print(isDarkMode);
    // final locationOverlay = await mapController.getLocationOverlay();

    // final darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // Provider.of<IsDarkMode>(context).changeMode(darkMode);
    // print(Provider.of<IsDarkMode>(context).isDarkMode);

    // final darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
// print(Provider.of<IsDarkMode>(context).isDarkMode);

    // final darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // print(darkMode);
    // () => context.read<IsDarkMode>().changeMode(darkMode);
    // print(context.read<IsDarkMode>().isDarkMode);
    // final darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // print('DarkMode : ${darkMode}');
    // print('DarkMode2 : ${Brightness}');

    // final darks = context.read<IsDarkMode>();
    // darks.changeMode(darkMode);

    // final value = Provider.of<IsDarkMode>(context, listen: false).changeMode(darkMode);

    return Scaffold(
      body: Stack(
        children: [
          NaverMap(
            options: NaverMapViewOptions(
              mapType: NMapType.navi,
              nightModeEnable: context.read<IsDarkMode>().isDarkMode,

              minZoom: 6,
              scaleBarEnable: false,
              locationButtonEnable: true,
              // 지도 영역을 한반도 인근으로 제한
              extent: NLatLngBounds(
                southWest: NLatLng(31.43, 122.37),
                northEast: NLatLng(44.35, 132.0),
              ),
            ),
            onMapReady: (controller) async {
              print("네이버 맵 로딩됨!");

              // Provider.of<IsDarkMode>(context).changeMode(true);
              // print(Provider.of<IsDarkMode>(context).isDarkMode);

              // final location = await controller.getLocationOverlay();
              // print('${location}');
              // controller.setLocationTrackingMode(NLocationTrackingMode.face);
              // final location = controller.getLocationTrackingMode();

              if (await getLocationPermission()) {
                // 권한 승인시
                controller.setLocationTrackingMode(NLocationTrackingMode.follow);
              } else {
                openAppSetting();
                // 권한 거부시 설정 이동 필요
              }
            },
          ),
          Positioned(child: Text('TEsttestsetestsetsetes'), top: 150),
          Positioned(
            top: 200,
            child: TextButton(
              onPressed: () {
                bool darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
                context.read<IsDarkMode>().changeMode(darkMode);
                print(context.read<IsDarkMode>().isDarkMode);
              },
              child: Text('asdfasfecraw3caw3crw3rcw'),
            ),
          )
        ],
      ),
    );
  }
}
