import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repository/hadiths/hadiths_repository_impl.dart';
import '../model/hadith_model.dart';

part 'hadiths_state.dart';

class HadithsCubit extends Cubit<HadithsState> {
  HadithsCubit(this.hadithsRepositoryImpl) : super(HadithsInitial());
  static HadithsCubit get(context) => BlocProvider.of(context);
  final HadithsRepositoryImpl hadithsRepositoryImpl;
  List<HadithsModel> hadiths = [];
  bool isFaild = false;bool isLoading=false;
  getHadiths() async {
    isLoading=true;
    emit(LoadingHadithState());
    final response = await hadithsRepositoryImpl.hadiths();
    response.fold((l) {
      isFaild = true;
    }, (right) {
      hadiths = right;
    });
isLoading=false;
    emit(GetHadithsState());
  }
}
