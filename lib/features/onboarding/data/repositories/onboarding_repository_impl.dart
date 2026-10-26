import 'package:mediconnect/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:mediconnect/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _localDataSource;

  const OnboardingRepositoryImpl(this._localDataSource);

  @override
  Future<bool> isOnboardingCompleted() async {
    return await _localDataSource.isOnboardingCompleted();
  }

  @override
  Future<void> setOnboardingCompleted() async {
    await _localDataSource.setOnboardingCompleted();
  }
}
