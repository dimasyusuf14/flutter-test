import 'package:flutter/material.dart';

class UpdateUserPage extends StatelessWidget {
  const UpdateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Update User Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}