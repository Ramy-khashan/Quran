import 'package:dio/dio.dart';
import '../../api/dio_consumer.dart';
import '../../../modules/quran_sound/model/quran_audio_model.dart';

import '../../api/exceptions.dart';

import 'package:dartz/dartz.dart';

import 'reciters_repository.dart';

class RecitersRepositoryImpl implements RecitersRepository {
  final DioConsumer dio;

  RecitersRepositoryImpl({required this.dio});
  List<QuranAudioModel> reciters = [];
  @override
  Future<Either<ServerException, List<QuranAudioModel>>> quranReciters() async {
    try {
      reciters = [];
      final res =
          await dio.get("https://www.mp3quran.net/api/v3/reciters?language=ar");

      for (var element in List.from(res["reciters"])) {
        reciters.add(QuranAudioModel.fromJson(element));
        print(
            "QuranAudioModel(id:${element["id"]},name:'${element["name"]}',letter:'${element["letter"]}',moshaf:[");
        element['moshaf'].forEach((v) {
          print(
              "Moshaf(id:${v['id']}, name:'${v['name']}', server:'${v['server']}',  surahTotal:${v['surah_total']},surahList:'${v['surah_list']}'),");
        });
        print("],),");
      }

      return right(reciters);
    } on DioError catch (e) {
      return left(ServerException(e.message.toString()));
    }
  }
}
