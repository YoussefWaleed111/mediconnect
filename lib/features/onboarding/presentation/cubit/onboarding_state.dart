import 'package:equatable/equatable.dart';
import 'package:mediconnect/features/onboarding/domain/models/onboarding_item.dart';

class OnboardingState extends Equatable {
  final int currentIndex;
  final List<OnboardingItem> items;
  final bool isCompleted;

  const OnboardingState({
    this.currentIndex = 0,
    required this.items,
    this.isCompleted = false,
  });

  bool get isLastPage => currentIndex == items.length - 1;

  OnboardingState copyWith({
    int? currentIndex,
    List<OnboardingItem>? items,
    bool? isCompleted,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      items: items ?? this.items,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [currentIndex, items, isCompleted];
}
