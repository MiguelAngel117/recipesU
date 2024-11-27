/*

Auth Gate - This will continously listen for auth state changes.


----------------------------------------------------------------------

unauthenticated -> Login page
authenticated -> Feed page

*/


import 'package:flutter/material.dart';
import 'package:recipes/pages/FeedPage.dart';
import 'package:recipes/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //Listen to auth states changes
      stream: Supabase.instance.client.auth.onAuthStateChange,
      //Bluid appropriate widget based on auth state
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } 

        //check if there is a valid session currently
        if (snapshot.hasData && snapshot.data != null) {
          return const FeedPage();
        } else {
          return const LoginPage();
        }

      },
    );
  }

}

