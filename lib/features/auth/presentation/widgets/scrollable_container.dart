import 'package:flutter/cupertino.dart';

class ScrollableContainer extends StatelessWidget{
  const ScrollableContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: child
        )
    );
  }

}