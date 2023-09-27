import 'package:hive/hive.dart';
part 'azkar_model.g.dart';

@HiveType(typeId: 0)
class AzkarModel extends HiveObject {
  @HiveField(0)
  int? iD;
  @HiveField(1)
  String? aRABICTEXT;
  @HiveField(2)
  String? lANGUAGEARABICTRANSLATEDTEXT;
  @HiveField(3)
  String? tRANSLATEDTEXT;
  @HiveField(4)
  int? rEPEAT;
  @HiveField(5)
  String? aUDIO;
  @HiveField(6)
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
