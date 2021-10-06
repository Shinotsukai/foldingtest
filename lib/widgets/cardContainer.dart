import 'package:flutter/material.dart';

import 'cardAdditional.dart';
import 'cardDetails.dart';
import 'cardFold.dart';
import 'cardSummary.dart';

class CardContainer extends StatefulWidget {
  @override
  _CardContainerState createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  bool _isOpen;
  CardSummary frontCard;
  CardSummary topCard;
  CardDetails middleCard;
  CardAdditional bottomCard;

  Widget get backCard => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0), color: Color(0xffdce6ef)),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isOpen = false;
    frontCard = CardSummary();
    middleCard = CardDetails();
    bottomCard = CardAdditional();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleOnTap,
      child: CardFold(entries: _getEntries(), isOpen: _isOpen),
    );
  }

  List<CardEntries> _getEntries() {
    return [
      CardEntries(height: 80.0, front: topCard),
      CardEntries(height: 160.0, front: middleCard, back: frontCard),
      CardEntries(height: 80.0, front: bottomCard, back: backCard),
    ];
  }

  void _handleOnTap() {
    setState(() {
      _isOpen = !_isOpen;
      topCard = CardSummary(
        isOpen: _isOpen,
      );
    });
  }
}
