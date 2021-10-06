import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  final bool isOpen;

  const CardSummary({Key key, this.isOpen = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _getBackgroundDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ListTile(
              leading: Icon(Icons.access_alarms),
              title: Text('0123456789'),
              subtitle: Text('Modified: 0/01/2020'),
            )
          ],
        ),
      ),
    );
  }

  Decoration _getBackgroundDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: Colors.white,
    );
  }
}
