class QuranAudioModel {
  int? id;
  String? name;
  String? letter;
  List<Moshaf>? moshaf;

  QuranAudioModel({this.id, this.name, this.letter, this.moshaf});

  QuranAudioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    letter = json['letter'];
    if (json['moshaf'] != null) {
      moshaf = <Moshaf>[];
      json['moshaf'].forEach((v) {
        moshaf!.add(Moshaf.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['letter'] = letter;
    if (moshaf != null) {
      data['moshaf'] = moshaf!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Moshaf {
  int? id;
  String? name;
  String? server;
  int? surahTotal;
  String? surahList;

  Moshaf({this.id, this.name, this.server, this.surahTotal, this.surahList});

  Moshaf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    server = json['server'];
    surahTotal = json['surah_total'];
    surahList = json['surah_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['server'] = server;
    data['surah_total'] = surahTotal;
    data['surah_list'] = surahList;
    return data;
  }
}
