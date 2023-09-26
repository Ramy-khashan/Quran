import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repository/hadiths_details/hadiths_details_repository_impl.dart';
import '../model/hadith_details_model.dart';

part 'hadith_details_state.dart';

class HadithDetailsCubit extends Cubit<HadithDetailsState> {
  HadithDetailsCubit(this.hadithsDetailsRepositoryImpl)
      : super(HadithDetailsInitial()) {
    scroll.addListener(loadMore);
  }

  static HadithDetailsCubit get(context) => BlocProvider.of(context);
  final HadithsDetailsRepositoryImpl hadithsDetailsRepositoryImpl;
  ScrollController scroll = ScrollController();
  int page = 1;
  int limit = 50;
  String slug = '';
  List<HadithsDetailsModel> hadiths = [];
  bool isFaild = false;
  bool isLoading = false;
  getHadithsDetails({required String slug}) async {
    isLoading = true;
    emit(LoadingHadithsDetailsState());
    this.slug = slug;
    final response = await hadithsDetailsRepositoryImpl.hadithsDetails(
        name: slug, page: page, limit: limit);
    response.fold((l) {
      isFaild = true;
    }, (right) {
      hadiths = right;
    });
    isLoading = false;
    emit(GetHadithsDetailsState());
  }

  bool isLaodingForMore = false;
  loadMore() async {
    if(scroll.position.pixels==scroll.position.maxScrollExtent){
    isLaodingForMore = true;
    emit(LoadMoreLoadidngHadithsDetailsState());
    page++; 
    final response = await hadithsDetailsRepositoryImpl.hadithsDetails(
        name: slug, page: page, limit: limit);
    response.fold((l) {
      isFaild = true;
    }, (right) {
      hadiths += right;
    });
    isLaodingForMore = false;
    emit(LoadMoreGetHadithsDetailsState());
      }  }
}
