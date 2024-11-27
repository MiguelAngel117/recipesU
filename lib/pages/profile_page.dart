import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recipes/auth/auth_service.dart';
import 'package:recipes/pages/recipe_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final randomFollowers =
      Random().nextInt(100000); // Genera un número aleatorio entre 0 y 99999
  final randomFollowing =
      Random().nextInt(100000); // Genera un número aleatorio entre 0 y 99999

  final formattedFollowers =
      '${(Random().nextInt(100000) / 1000).toStringAsFixed(1)}k';
  final formattedFollowing =
      '${(Random().nextInt(100000) / 1000).toStringAsFixed(1)}k';

  final List<Widget> myTabs = <Widget>[
    Tab(
      icon: Icon(
        Icons.local_pizza,
        color: Colors.grey,
      ),
    )
  ];

  final List<Widget> tabWidgets = [
    RecipePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: AppBar(
              title: Text(''),
              actions: [
                IconButton(
                    onPressed: () => {
                          AuthService().signOut(),
                          Navigator.pushNamed(context, '/login')
                        },
                    icon: Icon(Icons.logout))
              ],
            ),
            body: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //followings
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // ignore: prefer_interpolation_to_compose_strings
                        Text(formattedFollowing.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 5),
                        Text(
                          'Seguidos',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    //Profile pic
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://i.pinimg.com/736x/d5/c8/9b/d5c89bbffb0336f8409e0c91b9cb1f09.jpg'),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    //Followers
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formattedFollowers,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 5),
                        Text('Seguidores',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                //Profile name

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('|'),
                    Text(
                      'Chef',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                //tab bar
                TabBar(
                  tabs: myTabs,
                ),
                SizedBox(
                  height: 1000,
                  child: TabBarView(
                    children: tabWidgets,
                  ),
                )
              ],
            )));
  }
}
