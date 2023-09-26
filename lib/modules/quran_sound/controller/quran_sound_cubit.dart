 
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/repository/reciters_repository/reciters_repository_impl.dart';
import '../model/quran_audio_model.dart';

part 'quran_sound_state.dart';

class QuranSoundCubit extends Cubit<QuranSoundState> {
  final RecitersRepositoryImpl recitersRepositoryImpl;
  QuranSoundCubit(this.recitersRepositoryImpl) : super(QuranSoundInitial());
  static QuranSoundCubit get(context)=>BlocProvider.of(context);
  bool isLoadingReciters = false;
  List<QuranAudioModel> reciters = [];
  getRecitersValues() async {
    isLoadingReciters = true;
    emit(LoadingQuranSoundState());
    final response = await recitersRepositoryImpl.quranReciters();
    response.fold((l) {
      Fluttertoast.showToast(msg: l.toString());
      isLoadingReciters = false;
      emit(FaildGetQuranSoundState());
    }, (reciters) {
      this.reciters = reciters;
      isLoadingReciters = false;
      emit(SuccessGetQuranSoundState());
    });
  }
  int selectedMazhap=-1;
  showMazhap(int index){
    emit(QuranSoundInitial());

    selectedMazhap=index;
    emit(GetSelectedState());
  }
}
