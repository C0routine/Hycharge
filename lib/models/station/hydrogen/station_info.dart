class StationInfo {
  String? chrstnMno;
  String? chrstnNm;
  String? chrstnCttpc;
  String? roadNmAddr;
  String? lotnoAddr;
  String? cmptYn;
  String? chrstnTyCd;
  String? chrstnTyNm;
  String? echrgeqpTyCd;
  String? echrgeqpTyNm;
  String? chrgrTyCd;
  String? chrgrTyNm;
  String? chrstnTyRm;
  String? spldmdMnMthdCd;
  String? spldmdMnMthdNm;
  String? eventCn;
  String? vhcleKndCd;
  String? vhcleKndNm;
  int? ntslPc;
  String? setleMthdCd;
  String? setleMthdNm;
  String? usePosblDotw;
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
  String? operYn;
  String? delAt;
  String? lastMdfcnDt;
  String? timestamp;

  StationInfo(
      {this.chrstnMno,
      this.chrstnNm,
      this.chrstnCttpc,
      this.roadNmAddr,
      this.lotnoAddr,
      this.cmptYn,
      this.chrstnTyCd,
      this.chrstnTyNm,
      this.echrgeqpTyCd,
      this.echrgeqpTyNm,
      this.chrgrTyCd,
      this.chrgrTyNm,
      this.chrstnTyRm,
      this.spldmdMnMthdCd,
      this.spldmdMnMthdNm,
      this.eventCn,
      this.vhcleKndCd,
      this.vhcleKndNm,
      this.ntslPc,
      this.setleMthdCd,
      this.setleMthdNm,
      this.usePosblDotw,
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
      this.operYn,
      this.delAt,
      this.lastMdfcnDt,
      this.timestamp});

  StationInfo.fromJson(Map<String, dynamic> json) {
    chrstnMno = json['chrstn_mno'];
    chrstnNm = json['chrstn_nm'];
    chrstnCttpc = json['chrstn_cttpc'];
    roadNmAddr = json['road_nm_addr'];
    lotnoAddr = json['lotno_addr'];
    cmptYn = json['cmpt_yn'];
    chrstnTyCd = json['chrstn_ty_cd'];
    chrstnTyNm = json['chrstn_ty_nm'];
    echrgeqpTyCd = json['echrgeqp_ty_cd'];
    echrgeqpTyNm = json['echrgeqp_ty_nm'];
    chrgrTyCd = json['chrgr_ty_cd'];
    chrgrTyNm = json['chrgr_ty_nm'];
    chrstnTyRm = json['chrstn_ty_rm'];
    spldmdMnMthdCd = json['spldmd_mn_mthd_cd'];
    spldmdMnMthdNm = json['spldmd_mn_mthd_nm'];
    eventCn = json['event_cn'];
    vhcleKndCd = json['vhcle_knd_cd'];
    vhcleKndNm = json['vhcle_knd_nm'];
    ntslPc = json['ntsl_pc'];
    setleMthdCd = json['setle_mthd_cd'];
    setleMthdNm = json['setle_mthd_nm'];
    usePosblDotw = json['use_posbl_dotw'];
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
    operYn = json['oper_yn'];
    delAt = json['del_at'];
    lastMdfcnDt = json['last_mdfcn_dt'];
    timestamp = json['timestamp'];
  }

  // TODO 추후 API 직접 만들게 되면 인자값 필요할 수 있음, 그 전까지는 deprecated
  @Deprecated('request 일때 인자값이 아직 필요하지 않음')
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chrstn_mno'] = chrstnMno;
    return data;
  }
}
