import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  String? _role;
  String? get role => _role;
  User? get user => _user;

  AuthProvider() {
    _auth.authStateChanges().listen((user) async {
      _user = user;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        _role = doc['role'];
      }
      notifyListeners();
    });
  }

  Future<String?> login(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc = await _firestore.collection('users').doc(cred.user!.uid).get();
      _role = doc['role'];
      _user = cred.user;

      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signup(String email, String password, String name) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final role = 'user'; // Biar default role-nya user

      await _firestore.collection('users').doc(cred.user!.uid).set({
        'email': email,
        'name': name,
        'role': role,
      });

      _role = role;
      _user = cred.user;

      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _role = null;
    notifyListeners();
  }
}