import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignIn userSignIn,
    required UserSignUp userSignUp,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthSignUp>(_authSignup);
    on<AuthSignIn>(_authSignIn);
    on<IsUserLoggedIn>(_isCurrentUser);
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

  _isCurrentUser(IsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) {
        print(r.id);
        print(r.name);
        print(r.email);
        emit(
          AuthSuccess(r),
        );
      },
    );
  }
}
