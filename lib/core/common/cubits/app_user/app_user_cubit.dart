import 'package:blog_app/core/entity/user.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/usecase/user_sign_out.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final UserSignOut signOut;
  AppUserCubit({
    required this.signOut,
  }) : super(AppUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitial());
    }
    emit(AppUserLoggedIn(user!));
  }

  void userSignOut(BuildContext context) async {
    final res = await signOut(NoParams());

    res.fold((l) => showSnackbar(context, l.message), (r) {
      emit(
        AppUserInitial(),
      );
    });
  }
}
