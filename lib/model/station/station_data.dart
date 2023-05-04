class StationData {
  /// 충전소 관리번호
  String? stationId;

  /// 충전소 명
  String? name;

  /// 충전소 연락처
  String? number;

  ///  충전소 도로명 주소
  String? address;

  ///  충전소 지번 주소
  String? oldAddress;

  ///  충전소 전산여부, true - 표준, false - 비표준
  bool? standard;

  /// 충전소 유형 코드, 01:단독, 02:복합, 03:융합
  String? stationTypeCode;

  /// 충전소 유형명
  String? stationType;

  /// 충전소 유형 비고
  String? stationTypeETC;

  /// 충전소 수급방식 코드, 01:배관, 02:튜브트레일러, 03:기타
  String? supplyTypeCode;

  /// 충전소 수급방식명
  String? supplyType;

  /// 충전소 디스펜더 코드, 01 : Single Dispenser, 02 : Dual Dispenser
  String? dispenserTypeCode;

  /// 충전소 디스펜더명
  String? dispenserType;

  /// 충전소가 지원하는 차량 종류 코드,
  /// 01 : 승용차, 02 : 버스, 03 : 트럭, 04 : 특수, 05 : 일반,버스, 06 : 일반,버스,트럭
  String? supportVehicleCode;

  /// 충전소가 지원하는 차량 종류명
  String? supportVehicle;

  /// 판매가격
  int? price;

  /// 지원하는 결제방식 코드
  String? paymentCode;

  /// 지원하는 결제방식명
  String? payment;

  /// 충전소 이용가능 요일
  String? scheduleDay;

  /// 월요일 영업 시작 시간
  String? monStart;

  /// 월요일 영업 종료 시간
  String? monEnd;

  /// 화요일 영업 시작 시간
  String? tueStart;

  /// 화요일 영업 종료 시간
  String? tueEnd;

  /// 수요일 영업 시작 시간
  String? wedStart;

  /// 수요일 영업 종료 시간
  String? wedEnd;

  /// 목요일 영업 시작 시간
  String? thurStart;

  /// 목요일 영업 종료 시간
  String? thurEnd;

  /// 금요일 영업 시작 시간
  String? friStart;

  /// 금요일 영업 종료 시간
  String? friEnd;

  /// 토요일 영업 시작 시간
  String? satStart;

  /// 토요일 영업 종료 시간
  String? satEnd;

  /// 일요일 영업 시작 시간
  String? sunStart;

  /// 일요일 영업 종료 시간
  String? sunEnd;

  /// 공휴일 영업 시작 시간
  String? holStart;

  /// 공휴일 영업 종료 시간
  String? holEnd;

  /// 휴식 시작 시간
  String? breakStart;

  /// 휴식 종료 시간
  String? breakEnd;

  /// 예약가능 여부, true - 예약가능, false - 예약 불가능
  bool? supportReservation;

  /// 위도
  double? latitude;

  /// 경도
  double? longitude;

  /// 최근 수정일
  String? lastEdit;

  /// api 요청 시각
  String? timeStamp;

  //////////////// Not Define ////////////////
  /// 충전소 수급방식 코드인것 같음
  String? chargerTypeCode;

  /// 충전기 압력 수치 같음
  String? chargerType;

  /// 기타 안내사항 같음
  String? event;

  /// 의미를 모르겠음
  String? operYn;

  /// 의미를 모르겠음
  String? delAt;

  /////////////////////////////////////////////////
  /////// Split, Up StationInfo, Down StationDetail
  /////////////////////////////////////////////////

  /// TT 압력 수치 (supplyTypeCode : 01, 배관일 경우는 값이 없을 수 있음)
  int? pressure;

  /// 완충 가능 대수
  int? possibleVehicle;

  /// 현재 대기차 대수
  int? waitingVehicle;

  /// 혼잡 상태 코드
  /// 0:정보 없음, 1:여유, 2:보통, 3.혼잡 *여유(대기차량 0~1대), 보통(대기차량 2~4대), 혼잡(대기차량 5대이상),
  String? trafficTypeCode;

  /// 혼잡 상태명
  String? trafficType;

  /// 운영 상태 코드, 10:영업정지, 20:영업마감, 30:운영중
  String? statusCode;

  /// 운영 상태명
  String? status;

  /// POS 상태 코드, 0:영업중, 1:영업중지, 2:점검중, 3:T/T 교체중, 9:기타고장
  String? posStatusCode;

  /// POS 상태명
  String? posStatus;

  /// 운영 상태 갱신 일자, 실시간 운영정보업데이트(POS) 또는 충전원이 운영정보 업데이트 일자임
  String? statusUpdateTimeStamp;

  StationData({
    this.stationId,
    this.name,
    this.number,
    this.address,
    this.oldAddress,
    this.standard,
    this.stationTypeCode,
    this.stationType,
    this.stationTypeETC,
    this.supplyTypeCode,
    this.supplyType,
    this.dispenserTypeCode,
    this.dispenserType,
    this.supportVehicleCode,
    this.supportVehicle,
    this.price,
    this.paymentCode,
    this.payment,
    this.scheduleDay,
    this.monStart,
    this.monEnd,
    this.tueStart,
    this.tueEnd,
    this.wedStart,
    this.wedEnd,
    this.thurStart,
    this.thurEnd,
    this.friStart,
    this.friEnd,
    this.satStart,
    this.satEnd,
    this.sunStart,
    this.sunEnd,
    this.holStart,
    this.holEnd,
    this.breakStart,
    this.breakEnd,
    this.supportReservation,
    this.latitude,
    this.longitude,
    this.lastEdit,
    this.timeStamp,
    ///////////////
    this.chargerTypeCode,
    this.chargerType,
    this.event,
    this.operYn,
    this.delAt,
    ///////////////
    this.pressure,
    this.possibleVehicle,
    this.waitingVehicle,
    this.trafficTypeCode,
    this.trafficType,
    this.statusCode,
    this.status,
    this.posStatusCode,
    this.posStatus,
    this.statusUpdateTimeStamp,
  });

  StationData.fromJson(Map<String, dynamic> json) {
    stationId = json['chrstn_mno'];
    name = json['chrstn_nm'];
    number = json['chrstn_cttpc'];
    address = json['road_nm_addr'];
    oldAddress = json['lotno_addr'];
    standard = json['cmpt_yn'] == 'Y' ? true : false;
    stationTypeCode = json['chrstn_ty_cd'];
    stationType = json['chrstn_ty_nm'];
    stationTypeETC = json['chrstn_ty_rm'];
    supplyTypeCode = json['spldmd_mn_mthd_cd'];
    supplyType = json['spldmd_mn_mthd_nm'];
    dispenserTypeCode = json['echrgeqp_ty_cd'];
    dispenserType = json['echrgeqp_ty_nm'];
    supportVehicleCode = json['vhcle_knd_cd'];
    supportVehicle = json['vhcle_knd_nm'];
    price = json['ntsl_pc'];
    paymentCode = json['setle_mthd_cd'];
    payment = json['setle_mthd_nm'];
    scheduleDay = json['use_posbl_dotw'];
    monStart = json['usebhr_hr_mon'];
    monEnd = json['useehr_hr_mon'];
    tueStart = json['usebhr_hr_tues'];
    tueEnd = json['useehr_hr_tues'];
    wedStart = json['usebhr_hr_wed'];
    wedEnd = json['useehr_hr_wed'];
    thurStart = json['usebhr_hr_thur'];
    thurEnd = json['useehr_hr_thur'];
    friStart = json['usebhr_hr_fri'];
    friEnd = json['useehr_hr_fri'];
    satStart = json['usebhr_hr_sat'];
    satEnd = json['useehr_hr_sat'];
    sunStart = json['usebhr_hr_sun'];
    sunEnd = json['useehr_hr_sun'];
    holStart = json['usebhr_hr_hldy'];
    holEnd = json['useehr_hr_hldy'];
    breakStart = json['rest_bgng_hr'];
    breakEnd = json['rest_end_hr'];
    supportReservation = json['rsvt_posbl_yn'] == 'Y' ? true : false;
    latitude = double.parse(json['let'] ?? '0');
    longitude = double.parse(json['lon'] ?? '0');
    lastEdit = json['last_mdfcn_dt'];
    timeStamp = json['timestamp'];

    // 정의 되어있지 않은 api
    chargerTypeCode = json['chrgr_ty_cd'];
    chargerType = json['chrgr_ty_nm'];
    event = json['event_cn'];
    operYn = json['oper_yn'];
    delAt = json['del_at'];
    ///////////////
    stationId = json['chrstn_mno'];
    name = json['chrstn_nm'];
    pressure = json['tt_pressr'];
    possibleVehicle = json['prfect_elctc_posbl_alge'];
    waitingVehicle = json['wait_vhcle_alge'];
    trafficTypeCode = json['cnf_sttus_cd'];
    trafficType = json['cnf_sttus_nm'];
    statusCode = json['oper_sttus_cd'];
    status = json['oper_sttus_nm'];
    posStatusCode = json['pos_sttus_cd'];
    posStatus = json['pos_sttus_nm'];
    statusUpdateTimeStamp = json['last_mdfcn_dt'];
  }
}
