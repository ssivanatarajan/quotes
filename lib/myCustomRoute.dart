import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    var curve = Curves.easeInCirc;
    return new SlideTransition( position: Tween(
        begin: Offset(1.0, 0.0),
        end: Offset(0.0, 0.0)).chain(CurveTween(curve: curve))
        .animate(animation),
      child: child,);
  }
}