import 'package:mediconnect/features/onboarding/domain/repositories/onboarding_repository.dart';

class SetOnboardingCompletedUseCase {
  final OnboardingRepository _repository;

  const SetOnboardingCompletedUseCase(this._repository);

  Future<void> call() async {
    await _repository.setOnboardingCompleted();
  }
}
