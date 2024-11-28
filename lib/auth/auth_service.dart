import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase= Supabase.instance.client;

  //sign in with email and password
  
  Future<AuthResponse> signInWithEmailAndPassword(String email, String password) async {
    return _supabase.auth.signInWithPassword(email: email , password: password);
  }

  //sign up with email and password

  Future<AuthResponse> signUpWithEmailAndPassword(String email, String password) async {
    return _supabase.auth.signUp(email: email, password: password);
  }

  //sign out
  Future<void> signOut() async {
    return _supabase.auth.signOut();
  }

  //get current user
  String? getCurrentUser() {
    return _supabase.auth.currentUser?.email;
  }
}