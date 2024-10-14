import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recipes/pages/ListPage.dart';
import 'package:recipes/pages/PlanPage.dart';
import 'package:recipes/pages/favorite_recipes_page.dart';
import 'package:recipes/widgets/custom_fab.dart';

import 'HomePage.dart';
import 'SettingPage.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _HomePageState();
}

class _HomePageState extends State<FeedPage> {
  int index = 0;
  final screens = [
    HomePage(),
    FavoriteRecipesPage(),
    ListPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            body: screens[index],
            bottomNavigationBar: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: GNav(
                  onTabChange: (int index) {
                    setState(() {
                      this.index = index;
                    });
                  },
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Inicio',
                    ),
                    GButton(
                      icon: Icons.favorite,
                      text: 'Favoritos',
                    ),
                    GButton(
                      icon: Icons.calendar_today_rounded,
                      text: 'Plan',
                    ),
                    GButton(
                      icon: Icons.settings,
                      text: 'Ajustes',
                    ),
                  ],
                  gap: 8,
                  activeColor: Colors.lime,
                  iconSize: 24,
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  tabBackgroundColor: Colors.grey.shade800,
                  selectedIndex: index,
                ),
              ),
            ),
          ),
          // Posicionar el botón flotante centrado sobre el bottomNavigationBar
          Positioned(
            bottom: screenHeight * 0.07, // Ajusta la distancia desde abajo
            left: (screenWidth / 2) - 30, // Centrado, ajusta según el tamaño del FAB
            child: const CustomFAB(),
          ),
        ],
      ),
    );
  }
}
