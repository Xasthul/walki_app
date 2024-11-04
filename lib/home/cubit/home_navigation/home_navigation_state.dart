part of 'home_navigation_cubit.dart';

class HomeNavigationState extends Equatable {
  const HomeNavigationState(this.currentIndex);

  final int currentIndex;

  HomeNavigationState copyWith({int? currentIndex}) => HomeNavigationState(
        currentIndex ?? this.currentIndex,
      );

  @override
  List<Object?> get props => [currentIndex];
}
