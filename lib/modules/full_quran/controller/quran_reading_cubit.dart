import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/full_quran_model.dart';

part 'quran_reading_state.dart';

class FullQuranReadingCubit extends Cubit<FullQuranReadingState> {
  FullQuranReadingCubit() : super(QuranReadingInitial());
  static FullQuranReadingCubit get(context) => BlocProvider.of(context);

  List<FullQuranModel> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      surahList.add(FullQuranModel.fromMap(item));
    }
    emit(GetSurahNameState());
  }
}
