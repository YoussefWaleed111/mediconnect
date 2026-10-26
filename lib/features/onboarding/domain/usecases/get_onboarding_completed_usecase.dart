import 'package:mediconnect/features/onboarding/domain/repositories/onboarding_repository.dart';

class GetOnboardingCompletedUseCase {
  final OnboardingRepository _repository;

  const GetOnboardingCompletedUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.isOnboardingCompleted();
  }
}
