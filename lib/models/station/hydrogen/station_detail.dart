class StationDetail {
  String? chrstnMno;
  String? chrstnNm;
  int? ttPressr;
  int? prfectElctcPosblAlge;
  int? waitVhcleAlge;
  String? cnfSttusCd;
  String? cnfSttusNm;
  String? operSttusCd;
  String? operSttusNm;
  String? posSttusCd;
  String? posSttusNm;
  String? lastMdfcnDt;

  StationDetail(
      {this.chrstnMno,
      this.chrstnNm,
      this.ttPressr,
      this.prfectElctcPosblAlge,
      this.waitVhcleAlge,
      this.cnfSttusCd,
      this.cnfSttusNm,
      this.operSttusCd,
      this.operSttusNm,
      this.posSttusCd,
      this.posSttusNm,
      this.lastMdfcnDt});

  StationDetail.fromJson(Map<String, dynamic> json) {
    chrstnMno = json['chrstn_mno'];
    chrstnNm = json['chrstn_nm'];
    ttPressr = json['tt_pressr'];
    prfectElctcPosblAlge = json['prfect_elctc_posbl_alge'];
    waitVhcleAlge = json['wait_vhcle_alge'];
    cnfSttusCd = json['cnf_sttus_cd'];
    cnfSttusNm = json['cnf_sttus_nm'];
    operSttusCd = json['oper_sttus_cd'];
    operSttusNm = json['oper_sttus_nm'];
    posSttusCd = json['pos_sttus_cd'];
    posSttusNm = json['pos_sttus_nm'];
    lastMdfcnDt = json['last_mdfcn_dt'];
  }
}
