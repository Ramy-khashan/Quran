import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/modules/home_page/view/home_page_screen.dart';

import '../../azkar/view/azkar_screen.dart';
import '../../hadiths/view/hadiths_screen.dart';
import '../../prayers/view/prayers_screen.dart';

part 'navigator_bar_state.dart';

class NavigatorBarCubit extends Cubit<NavigatorBarState> {
  NavigatorBarCubit() : super(NavigatorBarInitial());
  static NavigatorBarCubit get(context) => BlocProvider.of(context);
  int selectedIndex = 0;
  List<Widget> pages = [
    const HomePageScreen(),
    const HadithsScreen(),
    const AzkarScreen(),
    const PrayersScreen(),
  ];
  changePage(selectedPage) {
    emit(NavigatorBarInitial());

    selectedIndex = selectedPage;
    emit(ChangePageState());
  }
}
