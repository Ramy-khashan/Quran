import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/function/convert_to_arabic.dart';
import '../model/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  static OnboardingCubit get(context) => BlocProvider.of(context);
  List<OnBoardingModel> onboardingItem = [
    OnBoardingModel(
        image: "logo.png",
        title: "قرأن",
        description: "القرأن وتعلم القران مع التفسير وسماع لاكثر من ${convertToArabic(100.toString())} شيخ"),
    OnBoardingModel(
        image: "hadiths.png",
        title: "الأحاديث",
        description: "جميع الأحاديث لأكثر من ${convertToArabic(8.toString())} علماء"),
    OnBoardingModel(
        image: "azkar.png",
        title: "الأذكار",
        description:
            "لذكر الله والحفاظ عليها يوميا باللغه العربيه والأنجليزيه"),
    OnBoardingModel(
        image: "prayer.png",
        title: "التسابيح",
        description:
            "التسابيح يمكن التسبيح الله باستخدام المسبحه الأكترونييه الخاصه بنا والحفاظ علي التسبيح يومياً"),
  ];
  int selectedPage = 0;
  getPageNumber(index) {
    emit(OnboardingInitial());

    selectedPage = index;
    emit(ChangePageState());
  }
}
