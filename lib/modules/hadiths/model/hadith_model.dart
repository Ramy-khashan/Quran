class HadithsModel {
  String? name;
  String? slug;
  int? total;

  HadithsModel({this.name, this.slug, this.total});

  HadithsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slug'] = slug;
    data['total'] = total;
    return data;
  }
}
