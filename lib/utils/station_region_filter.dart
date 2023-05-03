import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hycharge/models/station/hydrogen/station_list.dart';

/// 한국 행정구역(도, 특별시, 광역시) 지역별로 필터링한 Model
/// [total] - 지역의 충전소 개수, [priceFew] - 지역의 가격이 존재하는 충전소 개수, [totalPrice] - 지역의 총 가격
/// [name] - 단축된 지역명, [fullName] - 완전한 지역명, [nLatLng] - 지역 대표 좌표,
class RegionData {
  int total;
  int priceFew;
  int totalPrice;
  String name;
  String fullName;
  NLatLng nLatLng;

  RegionData(this.total, this.priceFew, this.totalPrice, this.name, this.fullName, this.nLatLng);
}

List<RegionData> stationRegionFilter(List<StationList> stationList) {
  List<RegionData> regionList = [
    RegionData(0, 0, 0, '서울', '서울특별시', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '부산', '부산광역시', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '대구', '대구광역시', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '인천', '인천광역시', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '광주', '광주광역시', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '대전', '대전광역시', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '울산', '울산광역시', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '세종', '세종특별자치시', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '경기', '경기도', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '강원', '강원도', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '충북', '충청북도', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '충남', '충청남도', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '전북', '전라북도', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '전남', '전라남도', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '경북', '경상북도', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '경남', '경상남도', const NLatLng(123.13, 123.13)),
    RegionData(0, 0, 0, '제주', '제주특별자치도', const NLatLng(123.13, 123.13)),
  ];

  for (int idx = 0; idx < stationList.length; idx++) {
    // station address null check
    if ((stationList[idx].address ?? '').isEmpty) continue;

    // region 마다 비교
    for (int rdx = 0; rdx < regionList.length; rdx++) {
      String adr = stationList[idx].address!;
      String nm = regionList[rdx].name;

      // 충전소 주소 길이에서 지역명 길이만큼 자르고, 해당 문자열에서 지역명과 같은게 있다면 동작 수행
      if ((nm.length <= adr.length) ? adr.substring(0, nm.length).contains(nm) : false) {
        regionList[rdx].total += 1;
        regionList[rdx].totalPrice += (stationList[idx].price ?? 0);
        regionList[rdx].priceFew += (stationList[idx].price != null ? 1 : 0);
        break;
      }

      // 충전소 주소 길이에서 지역명 풀네임 길이만큼 자르고, 해당 문자열에서 지역명 풀네임과 같은게 있다면 동작 수행
      nm = regionList[rdx].fullName;
      if ((nm.length <= adr.length) ? adr.substring(0, nm.length).contains(nm) : false) {
        regionList[rdx].total += 1;
        regionList[rdx].totalPrice += (stationList[idx].price ?? 0);
        regionList[rdx].priceFew += (stationList[idx].price != null ? 1 : 0);
        break;
      }
    }
  }

  return regionList;
}
