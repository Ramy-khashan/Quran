import 'package:hive_flutter/adapters.dart';
part 'quran_model.g.dart';

@HiveType(typeId: 1)
class QuranModel extends HiveObject {
  @HiveField(0)
  final String textAr;
  @HiveField(1)
  final String textEn;
  @HiveField(2)
  final String audio;
  @HiveField(3)
  final String audioFile;
  @HiveField(4)
  final String tafser;

  QuranModel(
      {required this.tafser,
      required this.audioFile,
      required this.textAr,
      required this.textEn,
      required this.audio});
}
