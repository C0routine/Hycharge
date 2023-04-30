import 'package:hycharge/service/network.dart';
import 'package:hycharge/models/station/hydrogen/station_list.dart';

/// (Hydrogen) 수소 충전소 관련 API 정의
class HydrogenStation {
  /// 충전소 운영 정보 List
  Future getStationList() async {
    final response = await Network.dio.get('/chrstnList/operationInfo');

    List<HydrogenStationList> stationList = [];
    response.data.forEach((station) => stationList.add(HydrogenStationList.fromJson(station)));

    return stationList;
  }

  /// 충전소 실시간 정보
  Future getStationRealtime() async {}
}
