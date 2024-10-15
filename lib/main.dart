import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:recipes/pages/FeedPage.dart';
import 'package:recipes/pages/recipe_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/expenses_provider.dart';
import 'package:recipes/providers/ui_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UIProvider()),
    ChangeNotifierProvider(create: (_) => ExpensesProvider())
  ], child: const MyApp()));
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
        '/': (context) => FeedPage(),
        '/recipeDetail': (context) => RecipeDetailPage(),
      },
    );
  }
}
