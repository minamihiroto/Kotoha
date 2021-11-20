import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Show extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('movies/background-sample.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 30),
            ),
          ),
        ),
      ],
    );
  }
}
