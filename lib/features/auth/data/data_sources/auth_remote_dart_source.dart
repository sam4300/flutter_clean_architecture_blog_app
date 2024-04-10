import 'package:blog_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDateSource {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDateSourceImpl implements AuthRemoteDateSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDateSourceImpl(this.supabaseClient);
  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (res.user == null) {
        throw ServerException('User is null');
      }
      return res.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
