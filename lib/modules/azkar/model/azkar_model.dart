class AzkarModel {
  int? iD;
  String? aRABICTEXT;
  String? lANGUAGEARABICTRANSLATEDTEXT;
  String? tRANSLATEDTEXT;
  int? rEPEAT;
  String? aUDIO; 
  String? text; 
  AzkarModel(
      {this.iD,
      this.aRABICTEXT,
      this.lANGUAGEARABICTRANSLATEDTEXT,
      this.tRANSLATEDTEXT,
      this.rEPEAT, 
      this.text, 
      this.aUDIO});

  AzkarModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    aRABICTEXT = json['ARABIC_TEXT'];
    lANGUAGEARABICTRANSLATEDTEXT = json['LANGUAGE_ARABIC_TRANSLATED_TEXT'];
    tRANSLATEDTEXT = json['TRANSLATED_TEXT'];
    rEPEAT = json['REPEAT'];
    text = json['Text'];
    aUDIO = json['AUDIO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['ARABIC_TEXT'] = aRABICTEXT;
    data['LANGUAGE_ARABIC_TRANSLATED_TEXT'] = lANGUAGEARABICTRANSLATEDTEXT;
    data['TRANSLATED_TEXT'] = tRANSLATEDTEXT;
    data['REPEAT'] = rEPEAT;
    data['AUDIO'] = aUDIO;
    return data;
  }
}
