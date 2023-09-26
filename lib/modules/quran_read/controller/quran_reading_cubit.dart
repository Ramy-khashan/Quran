import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/surah.dart';

part 'quran_reading_state.dart';

class QuranReadingCubit extends Cubit<QuranReadingState> {
  QuranReadingCubit() : super(QuranReadingInitial());
  static QuranReadingCubit get(context) => BlocProvider.of(context);

  List<Surah> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      surahList.add(Surah.fromMap(item));
    }
    emit(GetSurahNameState());
  }
}
