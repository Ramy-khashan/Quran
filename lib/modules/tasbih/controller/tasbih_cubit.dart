import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/function/shared_preferance_utils.dart';

part 'tasbih_state.dart';

class TasbihCubit extends Cubit<TasbihState> {
  TasbihCubit() : super(TasbihInitial());
  static TasbihCubit get(context) => BlocProvider.of(context);
  int tasbih = 0;
getPrayer(){
  String prayerVal=PreferenceUtils.getString("prayer");
 try{tasbih=prayerVal.isEmpty?0:int.parse(prayerVal);
}catch(e){
  tasbih=0;
}
emit(GetTasbihValuesState());


}
  bool isPressed = false;
  onTapUp() {
    emit(TasbihInitial());
    isPressed = false;
   tasbih++;
PreferenceUtils.setString("prayer",tasbih.toString());
    emit(OnPressUpState());
  }

  onTapDown() {
    emit(TasbihInitial());
    isPressed = true;
    emit(OnPressDownState());
  }
  reset(){
        tasbih=0;
PreferenceUtils.setString("prayer",tasbih.toString());
emit(ResetTasbihState());
  }
}
