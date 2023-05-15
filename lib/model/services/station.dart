import 'package:shared_preferences/shared_preferences.dart';

import 'package:hycharge/model/services/network.dart';
import 'package:hycharge/model/station/region_data.dart';
import 'package:hycharge/model/station/station_data.dart';

/// Singleton Pattern 으로 생성.
/// (Hydrogen) 수소 충전소 관련 API & Data 정의
class Station {
  static List<StationData> _stationDataList = [];
  static List<RegionData> _regionDataList = [];
  int _delayTimeStamp = 0;

  // 통합된 StationList Data
  static List<StationData> get stnList => _stationDataList;

  // 정리된 RegionList Data
  static List<RegionData> get reginList => _regionDataList;

  static final Station _station = Station._init();

  factory Station() {
    return _station;
  }

  Station._init();

  /// 충전소 정보 통합 List 가져오기 & 갱신 (성공시 true, 실패시 false)
  Future<bool> updateStationList() async {
    // delay 시간과 현재 시간을 비교 후 api 요청
    int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;

    if (_delayTimeStamp >= currentTimeStamp) {
      print('Request Delay... have time: ${((_delayTimeStamp - currentTimeStamp) / 1000).floor()}sec');
      return false;
    }

    final infoResponse = await Network.dio.get('/chrstnList/operationInfo');
    final detailsResponse = await Network.dio.get('/chrstnList/currentInfo');

    // 충전소 정보
    List<StationData> infoList = [];
    infoResponse.data.forEach((info) => infoList.add(StationData.fromJson(info)));
    // 충전소 실시간 정보
    List<StationData> detailList = [];
    detailsResponse.data.forEach((detail) => detailList.add(StationData.fromJson(detail)));

    // Json 가공 확인
    if (infoList.isEmpty || detailList.isEmpty) return false;

    // 통합한 충전소 정보
    List<StationData> stationList = [];
    // 실시간 정보(상세 정보) 값이 없는 station
    List<StationData> emptyDetailsList = [];

    // Favorite 된 station id data
    final SharedPreferences storage = await SharedPreferences.getInstance();
    List<String> favoriteList = storage.getStringList('favorite') ?? [];

    // 동기화 되지 않는 데이터 목록 필터링
    for (int info = 0; info < infoList.length; info++) {
      // 실시간 정보 있는지 확인하는 flag 값
      bool isEmpty = true;

      // 먼저 충전소 운영 정보 push, 실시간 정보 보다 많음
      if (infoList[info].stationId != null) {
        // Favorite 된 station 인지 확인.
        for (String fav in favoriteList) {
          if (infoList[info].stationId == fav) {
            infoList[info].isFavorite = true;
            break;
          }
        }

        stationList.add(infoList[info]);
      }

      for (int dex = 0; dex < detailList.length; dex++) {
        // 같은 id 값일 경우 값 동기화
        if (infoList[info].stationId == detailList[dex].stationId) {
          infoList[info].pressure = detailList[dex].pressure;
          infoList[info].possibleVehicle = detailList[dex].possibleVehicle;
          infoList[info].waitingVehicle = detailList[dex].waitingVehicle;
          infoList[info].trafficTypeCode = detailList[dex].trafficTypeCode;
          infoList[info].trafficType = detailList[dex].trafficType;
          infoList[info].statusCode = detailList[dex].statusCode;
          infoList[info].status = detailList[dex].status;
          infoList[info].posStatusCode = detailList[dex].posStatusCode;
          infoList[info].posStatus = detailList[dex].posStatus;
          infoList[info].statusUpdateTimeStamp = detailList[dex].statusUpdateTimeStamp;
          // 실시간 정보 값 있으므로 통과
          isEmpty = false;
          break;
        }
      }

      // 실시간 정보(상세 정보) 값이 없을 경우 추가
      if (isEmpty) {
        emptyDetailsList.add(infoList[info]);
      }
    }

    // Data 가공 확인
    if (stationList.isEmpty) return false;

    // Data Set
    _stationDataList = stationList;
    _regionDataList = stationRegionFilter(stationList);

    // delay TimeStamp Set
    _delayTimeStamp = DateTime.now().millisecondsSinceEpoch + 180000;
    // _delayTimeStamp = DateTime.now().millisecondsSinceEpoch + 30000;

    // Station Filter Result
    // print('\nStation List : ${infoList.length} \nStation Detail : ${detailList.length}'
    //     '\nStation Empty Detail : ${emptyDetailsList.length} '
    //     '\nStation Sync Failed Detail : ${detailList.length - (infoList.length - emptyDetailsList.length)}');
    print('Update Success StationList: ${_stationDataList.length}');

    return true;
  }
}
