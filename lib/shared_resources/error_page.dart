import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 20.0,
            ),
            Text("Something went wrong, please try later")
          ],
        ),
      ),
    );
  }
}
