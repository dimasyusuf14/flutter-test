import 'package:flutter/material.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Add User Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}