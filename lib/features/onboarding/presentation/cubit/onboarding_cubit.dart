import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediconnect/core/utils/app_assets.dart';
import 'package:mediconnect/features/onboarding/domain/models/onboarding_item.dart';
import 'package:mediconnect/features/onboarding/domain/usecases/set_onboarding_completed_usecase.dart';
import 'package:mediconnect/features/onboarding/presentation/cubit/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SetOnboardingCompletedUseCase setOnboardingCompletedUseCase;

  OnboardingCubit({
    required this.setOnboardingCompletedUseCase,
  }) : super(
          const OnboardingState(
            items: [
              OnboardingItem(
                image: AppAssets.onboardingConnected,
                title: 'Healthcare,\nConnected.',
                subtitle:
                    'Connect with trusted doctors and manage your healthcare journey in one place.',
                buttonText: 'Next',
              ),
              OnboardingItem(
                image: AppAssets.onboardingScheduling,
                title: 'Easy\nScheduling.',
                subtitle:
                    'Book appointments, virtual consultations, and in-person visits with just a few taps.',
                buttonText: 'Next',
              ),
              OnboardingItem(
                image: AppAssets.onboardingHistory,
                title: 'Your Health\nHistory.',
                subtitle:
                    'Access prescriptions, lab results, and medical records securely anytime, anywhere.',
                buttonText: 'Get Started',
              ),
            ],
          ),
        );

  void onPageChanged(int index) {
    if (index >= 0 && index < state.items.length) {
      emit(state.copyWith(currentIndex: index));
    }
  }

  Future<void> completeOnboarding() async {
    await setOnboardingCompletedUseCase();
    emit(state.copyWith(isCompleted: true));
  }
}
