import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/repository/azkar/azkar_repository_impl.dart';
import '../../azkar/model/azkar_model.dart';

part 'azkar_detailsl_state.dart';

class AzkarDetailsCubit extends Cubit<AzkarDetailslState> {
  AzkarDetailsCubit(this.azkarRepositoryImpl) : super(AzkarDetailslInitial()) ;
  final AzkarRepositoryImpl azkarRepositoryImpl;
  static AzkarDetailsCubit get(context) => BlocProvider.of(context);
  bool isLoading = true;
  bool isFaild = false;
  List<AzkarModel> azkar = [];
  getAzkarDetails({required int id, required String lang}) async {
    isLoading = true;
    emit(LoadingAzkardetailsState());
    final response = await azkarRepositoryImpl.azkar(azkarId: id,lang:lang);
    response.fold((l) {
isFaild=true;
    }, (r) {
      azkar = r;
    });
    isLoading = false;
    emit(GetAzkardetailsState());
  }

  int selectedOne = -1;
  AudioPlayer? audioPlayer;
  play(url, index) async {
   
    selectedOne = index;
    emit(StartAudioState());
    audioPlayer = AudioPlayer();

    if (audioPlayer!.playing) {
      await audioPlayer!.stop();
    }
    await audioPlayer!.setUrl(url);

    await audioPlayer!.play();
//     audioPlayer!.playerStateStream.listen((event) {
//       if(!event.playing){
//     selectedOne = -1;
// emit(StopAudioState());
//       }
//      });
 
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
