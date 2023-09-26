class HadithsDetailsModel {
  int? number;
  String? arab; 

  HadithsDetailsModel({this.number, this.arab});

  HadithsDetailsModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    arab = json['arab']; 
  }
 
}
