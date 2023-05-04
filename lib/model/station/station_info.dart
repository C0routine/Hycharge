class StationInfo {
  String? chrstnMno;
  String? chrstnNm;
  String? chrstnCttpc;
  String? roadNmAddr;
  String? lotnoAddr;
  String? cmptYn;
  String? chrstnTyCd;
  String? chrstnTyNm;
  String? chrstnTyRm;
  String? spldmdMnMthdCd;
  String? spldmdMnMthdNm;
  String? echrgeqpTyCd;
  String? echrgeqpTyNm;
  String? vhcleKndCd;
  String? vhcleKndNm;
  int? ntslPc;
  String? setleMthdCd;
  String? setleMthdNm;
  String? usePosblDotw;
  String? usebhrHrMon;
  String? useehrHrMon;
  String? usebhrHrTues;
  String? useehrHrTues;
  String? usebhrHrWed;
  String? useehrHrWed;
  String? usebhrHrThur;
  String? useehrHrThur;
  String? usebhrHrFri;
  String? useehrHrFri;
  String? usebhrHrSat;
  String? useehrHrSat;
  String? usebhrHrSun;
  String? useehrHrSun;
  String? usebhrHrHldy;
  String? useehrHrHldy;
  String? restBgngHr;
  String? restEndHr;
  String? rsvtPosblYn;
  String? lon;
  String? let;
  String? lastMdfcnDt;
  String? timestamp;

  // 정의 되어있지 않은 api
  /// 충전소 수급방식 코드인것 같음
  String? chrgrTyCd;

  /// 충전기 압력 수치 같음
  String? chrgrTyNm;

  /// 기타 안내사항 같음
  String? eventCn;

  // 의미를 모르겠음
  String? operYn;

  // 의미를 모르겠음
  String? delAt;

  StationInfo({
    this.chrstnMno,
    this.chrstnNm,
    this.chrstnCttpc,
    this.roadNmAddr,
    this.lotnoAddr,
    this.cmptYn,
    this.chrstnTyCd,
    this.chrstnTyNm,
    this.chrstnTyRm,
    this.spldmdMnMthdCd,
    this.spldmdMnMthdNm,
    this.echrgeqpTyCd,
    this.echrgeqpTyNm,
    this.vhcleKndCd,
    this.vhcleKndNm,
    this.ntslPc,
    this.setleMthdCd,
    this.setleMthdNm,
    this.usePosblDotw,
    this.usebhrHrMon,
    this.useehrHrMon,
    this.usebhrHrTues,
    this.useehrHrTues,
    this.usebhrHrWed,
    this.useehrHrWed,
    this.usebhrHrThur,
    this.useehrHrThur,
    this.usebhrHrFri,
    this.useehrHrFri,
    this.usebhrHrSat,
    this.useehrHrSat,
    this.usebhrHrSun,
    this.useehrHrSun,
    this.usebhrHrHldy,
    this.useehrHrHldy,
    this.restBgngHr,
    this.restEndHr,
    this.rsvtPosblYn,
    this.lon,
    this.let,
    this.lastMdfcnDt,
    this.timestamp,

    // 정의 되어있지 않은 api
    this.chrgrTyCd,
    this.chrgrTyNm,
    this.eventCn,
    this.operYn,
    this.delAt,
  });

  StationInfo.fromJson(Map<String, dynamic> json) {
    chrstnMno = json['chrstn_mno'];
    chrstnNm = json['chrstn_nm'];
    chrstnCttpc = json['chrstn_cttpc'];
    roadNmAddr = json['road_nm_addr'];
    lotnoAddr = json['lotno_addr'];
    cmptYn = json['cmpt_yn'];
    chrstnTyCd = json['chrstn_ty_cd'];
    chrstnTyNm = json['chrstn_ty_nm'];
    chrstnTyRm = json['chrstn_ty_rm'];
    spldmdMnMthdCd = json['spldmd_mn_mthd_cd'];
    spldmdMnMthdNm = json['spldmd_mn_mthd_nm'];
    echrgeqpTyCd = json['echrgeqp_ty_cd'];
    echrgeqpTyNm = json['echrgeqp_ty_nm'];
    vhcleKndCd = json['vhcle_knd_cd'];
    vhcleKndNm = json['vhcle_knd_nm'];
    ntslPc = json['ntsl_pc'];
    setleMthdCd = json['setle_mthd_cd'];
    setleMthdNm = json['setle_mthd_nm'];
    usePosblDotw = json['use_posbl_dotw'];
    usebhrHrMon = json['usebhr_hr_mon'];
    useehrHrMon = json['useehr_hr_mon'];
    usebhrHrTues = json['usebhr_hr_tues'];
    useehrHrTues = json['useehr_hr_tues'];
    usebhrHrWed = json['usebhr_hr_wed'];
    useehrHrWed = json['useehr_hr_wed'];
    usebhrHrThur = json['usebhr_hr_thur'];
    useehrHrThur = json['useehr_hr_thur'];
    usebhrHrFri = json['usebhr_hr_fri'];
    useehrHrFri = json['useehr_hr_fri'];
    usebhrHrSat = json['usebhr_hr_sat'];
    useehrHrSat = json['useehr_hr_sat'];
    usebhrHrSun = json['usebhr_hr_sun'];
    useehrHrSun = json['useehr_hr_sun'];
    usebhrHrHldy = json['usebhr_hr_hldy'];
    useehrHrHldy = json['useehr_hr_hldy'];
    restBgngHr = json['rest_bgng_hr'];
    restEndHr = json['rest_end_hr'];
    rsvtPosblYn = json['rsvt_posbl_yn'];
    lon = json['lon'];
    let = json['let'];
    lastMdfcnDt = json['last_mdfcn_dt'];
    timestamp = json['timestamp'];

    // 정의 되어있지 않은 api
    chrgrTyCd = json['chrgr_ty_cd'];
    chrgrTyNm = json['chrgr_ty_nm'];
    eventCn = json['event_cn'];
    operYn = json['oper_yn'];
    delAt = json['del_at'];
  }
}
