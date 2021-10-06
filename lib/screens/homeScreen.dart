import 'package:flutter/material.dart';
import 'package:foldingtest/widgets/cardContainer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardy Test'),
      ),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return CardContainer();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
