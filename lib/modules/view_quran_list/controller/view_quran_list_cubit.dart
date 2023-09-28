import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/surah_model.dart';

import '../../quran_read/model/surah.dart';

part 'view_quran_list_state.dart';

class ViewQuranListCubit extends Cubit<ViewQuranListState> {
  ViewQuranListCubit() : super(ViewQuranListInitial());
  static ViewQuranListCubit get(context) => BlocProvider.of(context);

  List<SurahModel> surah = [];
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      Surah surahItem = Surah.fromMap(item);

      String num = "";
      List.generate(3 - surahItem.id.toString().length, (index) => num += "0");
      num += "${surahItem.id}.mp3";
      surah.add(SurahModel(name: surahItem.arabicName, url: num));
    }
    emit(GetSurahNameState());
  }
}
