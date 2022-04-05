import 'package:flutter/material.dart';

class BottomSheetTopBar extends StatelessWidget {
  const BottomSheetTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Reiniciar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Aplicar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
