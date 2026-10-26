import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mediconnect/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:mediconnect/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:mediconnect/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mediconnect/features/onboarding/domain/usecases/get_onboarding_completed_usecase.dart';
import 'package:mediconnect/features/onboarding/domain/usecases/set_onboarding_completed_usecase.dart';
import 'package:mediconnect/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:mediconnect/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late OnboardingLocalDataSource localDataSource;
  late OnboardingRepository repository;
  late SetOnboardingCompletedUseCase setOnboardingCompletedUseCase;
  late GetOnboardingCompletedUseCase getOnboardingCompletedUseCase;
  late OnboardingCubit cubit;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    localDataSource = OnboardingLocalDataSourceImpl();
    repository = OnboardingRepositoryImpl(localDataSource);
    setOnboardingCompletedUseCase = SetOnboardingCompletedUseCase(repository);
    getOnboardingCompletedUseCase = GetOnboardingCompletedUseCase(repository);
    cubit = OnboardingCubit(
      setOnboardingCompletedUseCase: setOnboardingCompletedUseCase,
    );
  });

  Widget buildTestableWidget() {
    return MaterialApp(
      home: BlocProvider<OnboardingCubit>.value(
        value: cubit,
        child: const OnboardingView(),
      ),
    );
  }

  testWidgets('OnboardingView renders initial slide correctly', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text('Healthcare,\nConnected.'), findsOneWidget);
    expect(
      find.text(
        'Connect with trusted doctors and manage your healthcare journey in one place.',
      ),
      findsOneWidget,
    );
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
  });

  testWidgets('Clicking Next navigates through slides to Get Started', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    // Slide 1 -> Slide 2
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Easy\nScheduling.'), findsOneWidget);
    expect(
      find.text(
        'Book appointments, virtual consultations, and in-person visits with just a few taps.',
      ),
      findsOneWidget,
    );
    expect(find.text('Next'), findsOneWidget);

    // Slide 2 -> Slide 3
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Your Health\nHistory.'), findsOneWidget);
    expect(
      find.text(
        'Access prescriptions, lab results, and medical records securely anytime, anywhere.',
      ),
      findsOneWidget,
    );
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Completing onboarding marks state as completed in local storage', (tester) async {
    expect(await getOnboardingCompletedUseCase(), isFalse);

    await cubit.completeOnboarding();

    expect(await getOnboardingCompletedUseCase(), isTrue);
  });
}
