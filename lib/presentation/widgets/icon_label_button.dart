import 'package:flutter/material.dart';

class IconLabelButton extends StatelessWidget {
  const IconLabelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(120, 56), // button width and height
      child: Material(
        // button color
        child: InkWell(
          splashColor: Colors.green, // splash color
          onTap: () {}, // button pressed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.favorite_outline), // icon
              Text('Añadir a biblioteca'), // text
            ],
          ),
        ),
      ),
    );
  }
}
