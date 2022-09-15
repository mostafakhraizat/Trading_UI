class Trade {
  int? tICKET;
  String? sYMBOL;
  int? cMD;
  int? vOLUME;
  String? oPENTIME;
  double? oPENPRICE;
  String? cLOSETIME;
  double? cLOSEPRICE;
  double? pROFIT;

  Trade(
      {this.tICKET,
        this.sYMBOL,
        this.cMD,
        this.vOLUME,
        this.oPENTIME,
        this.oPENPRICE,
        this.cLOSETIME,
        this.cLOSEPRICE,
        this.pROFIT});

  Trade.fromJson(Map<String, dynamic> json) {
    tICKET = json['TICKET'];
    sYMBOL = json['SYMBOL'];
    cMD = json['CMD'];
    vOLUME = json['VOLUME'];
    oPENTIME = json['OPEN_TIME'];
    oPENPRICE = double.parse(json['OPEN_PRICE'].toString());
    cLOSETIME = json['CLOSE_TIME'];
    cLOSEPRICE = double.parse(json['CLOSE_PRICE'].toString());
    pROFIT = double.parse(json['PROFIT'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TICKET'] = tICKET;
    data['SYMBOL'] = sYMBOL;
    data['CMD'] = cMD;
    data['VOLUME'] = vOLUME;
    data['OPEN_TIME'] = oPENTIME;
    data['OPEN_PRICE'] = oPENPRICE;
    data['CLOSE_TIME'] = cLOSETIME;
    data['CLOSE_PRICE'] = cLOSEPRICE;
    data['PROFIT'] = pROFIT;
    return data;
  }
}