import 'package:equatable/equatable.dart';
import 'package:mediconnect/features/auth/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthSuccessState extends AuthState {
  final UserEntity user;

  const AuthSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthLoggedOutState extends AuthState {
  const AuthLoggedOutState();
}
