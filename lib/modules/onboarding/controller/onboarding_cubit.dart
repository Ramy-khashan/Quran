import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  static OnboardingCubit get(context) => BlocProvider.of(context);
  List<OnBoardingModel> onboardingItem = [
    OnBoardingModel(
        image: "logo.png",
        title: "قرأن",
        description: "Can read and hear quran with many voices."),
    OnBoardingModel(
        image: "hadiths.png",
        title: "الأحاديث",
        description: "With 9 sheikh you can read all hadiths."),
    OnBoardingModel(
        image: "azkar.png",
        title: "الأذكار",
        description:
            "Azkar with all type provided with voice and with differant language ( English - Arabic )"),
    OnBoardingModel(
        image: "prayer.png",
        title: "التسابيح",
        description:
            "Tasbih zikr Allah with counting to fulfill your daily zikr"),
  ];
  int selectedPage = 0;
  getPageNumber(index) {
    emit(OnboardingInitial());

    selectedPage = index;
    emit(ChangePageState());
  }
}
