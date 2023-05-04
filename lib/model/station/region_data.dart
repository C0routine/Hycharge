import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:hycharge/model/station/station_data.dart';

/// 한국 행정구역(도, 특별시, 광역시) 지역별로 필터링한 Model
class RegionData {
  /// 지역의 충전소 개수
  int total;

  /// 지역의 가격이 존재하는 충전소 개수
  int priceFew;

  /// 지역의 총 가격
  int totalPrice;

  /// 단축된 지역명
  String name;

  /// 완전한 지역명
  String fullName;

  /// 지역 대표 좌표
  NLatLng nLatLng;

  // double lat;
  // double lng;

  RegionData(
    this.total,
    this.priceFew,
    this.totalPrice,
    this.name,
    this.fullName,
    this.nLatLng,
    // this.lat, this.lng
  );
}

List<RegionData> stationRegionFilter(List<StationData> stationList) {
  List<RegionData> regionList = [
    RegionData(0, 0, 0, '서울', '서울특별시', const NLatLng(37.54914373424705, 126.93783068958686)),
    RegionData(0, 0, 0, '부산', '부산광역시', const NLatLng(35.195961082592, 129.01100887738826)),
    RegionData(0, 0, 0, '대구', '대구광역시', const NLatLng(35.82722695945298, 128.5421083539038)),
    RegionData(0, 0, 0, '인천', '인천광역시', const NLatLng(37.48179597845692, 126.59152413044244)),
    RegionData(0, 0, 0, '광주', '광주광역시', const NLatLng(35.163731061579576, 126.8445665564464)),
    RegionData(0, 0, 0, '대전', '대전광역시', const NLatLng(36.35503793769152, 127.39240835078374)),
    RegionData(0, 0, 0, '울산', '울산광역시', const NLatLng(35.5265403575817, 129.3004075736454)),
    RegionData(0, 0, 0, '세종', '세종특별자치시', const NLatLng(36.48581065557235, 127.26456289999535)),
    RegionData(0, 0, 0, '경기', '경기도', const NLatLng(37.256778470609454, 127.04679913060124)),
    RegionData(0, 0, 0, '강원', '강원도', const NLatLng(37.66953528323109, 128.46852068464358)),
    RegionData(0, 0, 0, '충북', '충청북도', const NLatLng(36.849174876906396, 127.65674368548981)),
    RegionData(0, 0, 0, '충남', '충청남도', const NLatLng(36.79881229803447, 126.8229999731998)),
    RegionData(0, 0, 0, '전북', '전라북도', const NLatLng(35.82182994211044, 127.09343774443386)),
    RegionData(0, 0, 0, '전남', '전라남도', const NLatLng(35.003803890146514, 127.26897761854605)),
    RegionData(0, 0, 0, '경북', '경상북도', const NLatLng(36.13629736398664, 128.4842402833116)),
    RegionData(0, 0, 0, '경남', '경상남도', const NLatLng(35.22148844216947, 128.58939161348664)),
    RegionData(0, 0, 0, '제주', '제주특별자치도', const NLatLng(33.499598, 126.531296)),
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
        // regionList[rdx].lat += stationList[idx].latitude!;
        // regionList[rdx].lng += stationList[idx].longitude!;
        break;
      }

      // 충전소 주소 길이에서 지역명 풀네임 길이만큼 자르고, 해당 문자열에서 지역명 풀네임과 같은게 있다면 동작 수행
      nm = regionList[rdx].fullName;
      if ((nm.length <= adr.length) ? adr.substring(0, nm.length).contains(nm) : false) {
        regionList[rdx].total += 1;
        regionList[rdx].totalPrice += (stationList[idx].price ?? 0);
        regionList[rdx].priceFew += (stationList[idx].price != null ? 1 : 0);
        // regionList[rdx].lat += stationList[idx].latitude!;
        // regionList[rdx].lng += stationList[idx].longitude!;
        break;
      }
    }
  }

  // 평균 좌표값
  // for (Region r in regionList) {
  //   print('lat : ${r.fullName}');
  //   print('lat : ${r.lat / r.total}, ${r.lng / r.total}');
  // }

  return regionList;
}
