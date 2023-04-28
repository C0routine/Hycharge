import 'package:hycharge/service/network.dart';

/// (Hydrogen) 수소 충전소 관련 API 정의
class HydrogenStation {
  /// 충전소 운영 정보 List
  Future getStationList() async {
    final response = await Network.dio.get('/chrstnList/operationInfo');

    // print(response.data[0]['chrstn_mno']);
    // print(response.statusMessage);
    return response;
  }

  /// 충전소 실시간 정보
  Future getStationRealtime() async {}
}
