import 'dart:async';

import 'package:business_card/features/auth/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance,
      super(const AuthState()) {
    _apply(_auth.currentUser);
    _sub = _auth.authStateChanges().listen(_apply);
  }

  final FirebaseAuth _auth;
  late final StreamSubscription<User?> _sub;

  void _apply(User? user) {
    if (isClosed) return;
    if (user == null) {
      emit(const AuthState());
    } else {
      emit(AuthState(status: AuthStatus.authenticated, email: user.email));
    }
  }

  Future<void> signUp(String email, String password) => _run(
    () => _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    ),
  );

  Future<void> signIn(String email, String password) => _run(
    () => _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    ),
  );

  Future<void> signOut() async {
    await _auth.signOut();
    _apply(null);
  }

  void clearError() {
    if (state.error != null) emit(state.copyWith(clearError: true));
  }

  Future<void> _run(Future<UserCredential> Function() action) async {
    if (state.loading) return;
    emit(state.copyWith(loading: true, clearError: true));
    try {
      final cred = await action();
      _apply(cred.user);
    } on FirebaseAuthException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(loading: false, error: _message(e.code)));
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          loading: false,
          error: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  String _message(String code) {
    switch (code) {
      case 'invalid-email':
        return 'This email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Wrong email or password.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'network-request-failed':
        return 'No internet connection.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'operation-not-allowed':
        return 'Email/Password sign-in is not enabled in Firebase.';
      default:
        return 'Something went wrong ($code).';
    }
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}
