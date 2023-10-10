 
class FullQuranModel {
  int id;
  String revelationPlace;
  int revelationOrder;
  String name;
  String arabicName;
  int versesCount;
  List pages;
  FullQuranModel({
    required this.arabicName,
    required this.pages,
    required this.id,
    required this.name,
    required this.revelationOrder,
    required this.revelationPlace,
    required this.versesCount,
  });
  factory FullQuranModel.fromMap(Map<String, dynamic> json) => FullQuranModel(
        arabicName: json["name_arabic"],
        id: json["id"],
        pages: json["pages"],
        name: json["name_simple"],
        revelationOrder: json["revelation_order"],
        revelationPlace: json["revelation_place"],
        versesCount: json["verses_count"],
      );
}
