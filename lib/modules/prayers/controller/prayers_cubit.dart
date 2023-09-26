import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/function/shared_preferance_utils.dart';

part 'prayers_state.dart';

class PrayersCubit extends Cubit<PrayersState> {
  PrayersCubit() : super(PrayersInitial());
  static PrayersCubit get(context) => BlocProvider.of(context);
  int prayers = 0;
getPrayer(){
  String prayerVal=PreferenceUtils.getString("prayer");
 try{prayers=prayerVal.isEmpty?0:int.parse(prayerVal);
}catch(e){
  prayers=0;
}
emit(GetPrayersValuesState());


}
  bool isPressed = false;
  onTapUp() {
    emit(PrayersInitial());
    isPressed = false;
    prayers++;
PreferenceUtils.setString("prayer",prayers.toString());
    emit(OnPressUpState());
  }

  onTapDown() {
    emit(PrayersInitial());
    isPressed = true;
    emit(OnPressDownState());
  }
}
