import 'package:dio/dio.dart';
import 'package:quran_app/core/api/dio_consumer.dart';
import 'package:quran_app/modules/quran_read/model/quran_model.dart';

class QuranImpl {
  getQuran(int index) async {
    List<QuranModel> quran = [];
    final response = await DioConsumer(client: Dio()).get(
        "http://api.alquran.cloud/v1/surah/$index/editions/ar.alafasy,en.pickthall");
      
    List dataAr = List.from(response["data"][0]["ayahs"]);
    List dataEn = List.from(response["data"][1]["ayahs"]);
    for (int i = 0; i < dataAr.length; i++) {
      final tafser = await DioConsumer(client: Dio()).get(
        "http://api.quran-tafseer.com/tafseer/1/${index}/${i+1}");
      quran.add(
        QuranModel(
            textAr: dataAr[i]["text"],
            textEn: dataEn[i]["text"],
            audio: dataAr[i]["audio"],
            audioFile: "", tafser: tafser["text"]),
      );
    }
    return quran;
  }
}
