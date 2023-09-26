import 'package:dartz/dartz.dart';

import '../../../modules/quran_sound/model/quran_audio_model.dart';
import '../../api/exceptions.dart';

abstract class RecitersRepository {
  Future<Either< ServerException,List<QuranAudioModel>>> quranReciters();
}
