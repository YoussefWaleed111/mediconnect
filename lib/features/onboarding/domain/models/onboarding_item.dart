import 'package:equatable/equatable.dart';

class OnboardingItem extends Equatable {
  final String image;
  final String title;
  final String subtitle;
  final String buttonText;

  const OnboardingItem({
    required this.image,
    required this.title,
    required this.subtitle,
    this.buttonText = 'Next',
  });

  @override
  List<Object?> get props => [image, title, subtitle, buttonText];
}
