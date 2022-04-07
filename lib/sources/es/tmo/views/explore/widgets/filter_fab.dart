import 'package:flutter/material.dart';

class FilterFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterFAB({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const Icon(Icons.filter_list),
      label: const Text(
        'Filtrar',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.black,
      isExtended: true,
    );
  }
}
