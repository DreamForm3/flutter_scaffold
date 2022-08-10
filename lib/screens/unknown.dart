import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ERROR!')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            'ERROR: 404\n\n\nPAGE NOT FOUND!',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}