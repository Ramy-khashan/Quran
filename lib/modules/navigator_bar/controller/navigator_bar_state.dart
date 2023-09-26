part of 'navigator_bar_cubit.dart';

 abstract class NavigatorBarState extends Equatable {
  const NavigatorBarState();

  @override
  List<Object> get props => [];
}

  class NavigatorBarInitial extends NavigatorBarState {}
  class ChangePageState extends NavigatorBarState {}
