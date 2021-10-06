import 'package:flutter/material.dart';

class CardAdditional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: RaisedButton(
            onPressed: () {},
            child: Text('Add Additional Test'),
          )),
    );
  }
}
