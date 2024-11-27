import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:recipes/pages/FeedPage.dart';
import 'package:recipes/pages/login_page.dart';
import 'package:recipes/pages/recipe_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/expenses_provider.dart';
import 'package:recipes/providers/recipe_db.dart';
import 'package:recipes/providers/ui_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{

  await Supabase.initialize(
    url: 'https://qbgntesbnpdtlgknvmcj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFiZ250ZXNibnBkdGxna252bWNqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1ODIxNTYsImV4cCI6MjA0ODE1ODE1Nn0.-ZL75xYPsiaAKqQqucUwhw2dH2jowultvc6cjoK32KI',
  );


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UIProvider()),
    ChangeNotifierProvider(create: (_) => ExpensesProvider())
  ], child: const MyApp()));
  //await RecipeDatabase.db.initializeDefaultRecipes();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipies',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'CO')],
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/feed': (context) => const FeedPage(),
        '/recipeDetail': (context) => RecipeDetailPage(),
      },
    );
  }
}
