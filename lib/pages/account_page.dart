import 'package:flutter/material.dart';
import 'package:recipes/widgets/account/user_recipes_widget.dart';
import 'package:recipes/widgets/account/user_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              print('A futuro permitira editar');
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              UserWidget(),
              SizedBox(height: 24.0),
              UserRecipesWidget()
            ],
          ),
        ),
      ),
    );
  }
}
