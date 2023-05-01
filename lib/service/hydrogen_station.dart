import 'package:hycharge/service/network.dart';
import 'package:hycharge/models/station/hydrogen/station_list.dart';
import 'package:hycharge/models/station/hydrogen/station_info.dart';
import 'package:hycharge/models/station/hydrogen/station_detail.dart';

/// (Hydrogen) 수소 충전소 관련 API 정의
class HydrogenStation {
  /// 충전소 운영 정보 List
  Future getStationInfo() async {
    final response = await Network.dio.get('/chrstnList/operationInfo');

    List<StationInfo> stationList = [];
    response.data.forEach((station) => stationList.add(StationInfo.fromJson(station)));

    return stationList;
  }

  /// 충전소 실시간 정보
  Future getStationDetails() async {
    final response = await Network.dio.get('/chrstnList/currentInfo');

    List<StationDetail> stationList = [];
    response.data.forEach((station) => stationList.add(StationDetail.fromJson(station)));

    return stationList;
  }

  /// 충전소 정보 통합 List
  Future getStationList() async {
    final infoResponse = await Network.dio.get('/chrstnList/operationInfo');
    final detailsResponse = await Network.dio.get('/chrstnList/currentInfo');

    List<StationList> infoList = [];
    infoResponse.data.forEach((info) => infoList.add(StationList.fromJson(info)));
    List<StationList> detailList = [];
    detailsResponse.data.forEach((detail) => detailList.add(StationList.fromJson(detail)));

    List<StationList> stationList = [];
    List<StationList> emptyDetailsList = [];

    // 동기화 되지 않는 데이터 목록 필터링
    for (int info = 0; info < infoList.length - 1; info++) {
      // 실시간 정보 있는지 확인하는 flag 값
      bool isEmpty = true;

      // 먼저 충전소 운영 정보 push, 실시간 정보 보다 많음
      stationList.add(infoList[info]);

      for (int dex = 0; dex < detailList.length - 1; dex++) {
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

    // Station Filter Result
    print('\nStation List : ${infoList.length} \nStation Detail : ${detailList.length}'
        '\nStation Empty Detail : ${emptyDetailsList.length} '
        '\nStation Sync Failed Detail : ${detailList.length - (infoList.length - emptyDetailsList.length)}');
    return stationList;
  }
}
