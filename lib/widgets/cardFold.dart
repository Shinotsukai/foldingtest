import 'dart:math';

import 'package:flutter/material.dart';

class CardFold extends StatefulWidget {
  static const double padding = 16.0;
  final bool isOpen;
  final List<CardEntries> entries;
  final Duration duration;

  CardFold({this.entries, this.isOpen = false, this.duration});

  @override
  _CardFoldState createState() => _CardFoldState();
}

class _CardFoldState extends State<CardFold>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _ratio = 0.0;
  List<CardEntries> _entries;

  double get openHeight =>
      _entries.fold(0.0, (val, o) => val + o.height) + CardFold.padding * 2;

  double get closedHeight => _entries[0].height + CardFold.padding * 2;

  bool get isOpen => widget.isOpen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_tick);
    _updateFromWidget();
  }

  @override
  void didUpdateWidget(CardFold oldWidget) {
    // TODO: implement didUpdateWidget
    isOpen ? _controller.forward() : _controller.reverse();
    _updateFromWidget();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CardFold.padding),
      height: closedHeight +
          (openHeight - closedHeight) * Curves.easeOut.transform(_ratio),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        child: _buildEntry(0),
      ),
    );
  }

  Widget _buildEntry(int index, [double offset = 0.0]) {
    int count = _entries.length - 1;
    CardEntries entry = _entries[index];
    double ratio = max(0.0, min(1.0, _ratio * count + 1.0 - index * 1.0));

    Matrix4 matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..setEntry(1, 2, 0.2)
      ..translate(0.0, offset)
      ..rotateX(pi * (ratio - 1.0));

    Widget card = SizedBox(
      height: entry.height,
      child: ratio < 0.5 ? entry.back : entry.front,
    );

    return Transform(
      alignment: Alignment.topCenter,
      transform: matrix,
      child: Container(
        child: (index == count || ratio <= 0.5)
            ? card
            : Stack(
                children: [card, _buildEntry(index + 1, entry.height)],
              ),
      ),
    );
  }

  void _updateFromWidget() {
    _entries = widget.entries;

    _controller.duration =
        widget.duration ?? Duration(milliseconds: 400 * (_entries.length - 1));
  }

  void _tick() {
    setState(() {
      _ratio = Curves.easeInQuad.transform(_controller.value);
    });
  }
}

class CardEntries {
  final Widget front;
  Widget back;
  final double height;

  CardEntries({this.front, this.height, Widget back}) {
    this.back = Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, .001)
        ..rotateX(pi),
      child: back,
    );
  }
}
