import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit() : super(const HomeNavigationState(0));

  void updateCurrentIndex(int index) => emit(HomeNavigationState(index));

  void openTripPage() => emit(const HomeNavigationState(0));
}
