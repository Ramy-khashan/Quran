 
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../core/data/shikhs.dart'; 
import '../model/quran_audio_model.dart';

part 'quran_sound_state.dart';

class QuranSoundCubit extends Cubit<QuranSoundState> { 
  QuranSoundCubit( ) : super(QuranSoundInitial());
  static QuranSoundCubit get(context)=>BlocProvider.of(context); 
  List<QuranAudioModel> reciters =SheikhData.sheikh;
   
  int selectedMazhap=-1;
  showMazhap(int index){
    emit(QuranSoundInitial());

    selectedMazhap=index;
    emit(GetSelectedState());
  }
}
