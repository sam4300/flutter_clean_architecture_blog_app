import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/entity/user.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/usescases/current_user.dart';
import 'package:blog_app/features/auth/domain/usescases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usescases/user_sign_up.dart';
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
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSighUp>(_authSignUp);
    on<AuthSignIn>(_authSignIn);
    on<AuthCurrentUser>(_authCurrentUser);
  }

  void _authSignUp(AuthSighUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignupParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    res.fold(
      (l) => emit(
        AuthFailure(l.message),
      ),
      (r) => _updateUser(r, emit),
    );
  }

  void _authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));
    res.fold(
      (l) => emit(
        AuthFailure(l.message),
      ),
      (r) => _updateUser(r, emit),
    );
  }

  void _authCurrentUser(
    AuthCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(
      NoParams(),
    );
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _updateUser(r, emit),
    );
  }

  void _updateUser(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(
      AuthSuccess(user),
    );
  }
}
