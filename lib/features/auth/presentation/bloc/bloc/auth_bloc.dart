import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  AuthBloc({
    required UserSignIn userSignIn,
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        super(AuthInitial()) {
    on<AuthSignUp>(_authSignup);
    on<AuthSignIn>(_authSignIn);
  }
  _authSignup(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userSignUp(UserSignUpParams(
        email: event.email, password: event.password, name: event.name));
    res.fold(
      (faliure) => emit(
        AuthFailure(faliure.message),
      ),
      (user) => emit(
        AuthSuccess(user),
      ),
    );
  }

  _authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));
    res.fold(
      (faliure) => emit(
        AuthFailure(faliure.message),
      ),
      (user) => emit(
        AuthSuccess(user),
      ),
    );
  }
}
