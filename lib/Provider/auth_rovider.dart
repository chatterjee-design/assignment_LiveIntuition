import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _setLoading(true);

    try {
       await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _setLoggedIn(true);
      _showToast("Registration successful", Colors.green);
    } on FirebaseAuthException catch (e) {
      _setLoggedIn(false);
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use.';
      } else {
        errorMessage = e.message ?? 'An error occurred';
      }
      _showToast(errorMessage, Colors.red);
    } catch (e) {
      _showToast('An error occurred', Colors.red);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signIn(String email, String password) async {
    _setLoading(true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _setLoggedIn(true);

      _showToast("Sign-in successful", Colors.green);
    } on FirebaseAuthException catch (e) {
      _setLoggedIn(false);
      String errorMessage;
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorMessage = 'Invalid email or password';
      } else {
        errorMessage = e.message ?? 'An error occurred';
      }
      _showToast(errorMessage, Colors.red);
    } catch (e) {
      _showToast('An error occurred', Colors.red);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _setLoggedIn(false);
    } catch (e) {
      _showToast('An error occurred while logging out', Colors.red);
    }
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }
}
