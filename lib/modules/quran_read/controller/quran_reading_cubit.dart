 
import 'package:equatable/equatable.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';

 
part 'quran_reading_state.dart';

class QuranReadingCubit extends Cubit<QuranReadingState> {
  QuranReadingCubit() : super(QuranReadingInitial());
  static QuranReadingCubit get(context) => BlocProvider.of(context);
 
  int selectedIndex = 0;
  bool isReverse = false;
  
}
