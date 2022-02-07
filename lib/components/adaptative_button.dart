import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  AdaptativeButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Theme.of(context).primaryColor,
            child: Text(label),
            onPressed: () => onPressed,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: TextStyle(
                color: Theme.of(context).textTheme.button?.color,
              ),
            ),
            child: Text(label),
            onPressed: () => onPressed,
          );
  }
}
