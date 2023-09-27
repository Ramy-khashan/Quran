import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/core/utils/app_string.dart';

import '../../../core/repository/azkar/azkar_repository_impl.dart';
import '../../azkar/model/azkar_model.dart';

part 'azkar_detailsl_state.dart';

class AzkarDetailsCubit extends Cubit<AzkarDetailslState> {
  AzkarDetailsCubit(this.azkarRepositoryImpl) : super(AzkarDetailslInitial()) {
    audioPlayer = AudioPlayer();
  }
  final AzkarRepositoryImpl azkarRepositoryImpl;
  static AzkarDetailsCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;
  bool isFaild = false;
  List<AzkarModel> azkar = [];
  var hiveBox = Hive.box(AppString.azkarHiveBox);
 

  int selectedOne = -1;
  AudioPlayer? audioPlayer;
  play(url, index) async {
    selectedOne = index;
    emit(StartAudioState());

    if (audioPlayer!.playing) {
      await audioPlayer!.stop();
    }
    await audioPlayer!.setUrl(url);

    await audioPlayer!.play();
 

    emit(PlayAudioState());
  }

  stop() {
    audioPlayer!.stop();
    selectedOne = -1;
    emit(StopAudioState());
  }

  @override
  Future<void> close() async {
    await audioPlayer!.dispose();

    return super.close();
  }
}
