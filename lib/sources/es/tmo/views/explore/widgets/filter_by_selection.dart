import 'package:flutter/material.dart';
import 'package:meronpan/domain/sources/utils/pair.dart';

class FilterBySelection extends StatelessWidget {
  final String? title;
  final String label;
  final List<Pair> items;
  final Function(int)? onChanged;
  final Pair value;

  const FilterBySelection({
    Key? key,
    this.title,
    required this.label,
    required this.items,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          Row(
            children: [
              Expanded(child: Text(label)),
              Expanded(
                child: DropdownButton<Pair>(
                  value: value,
                  items: items.map<DropdownMenuItem<Pair>>((Pair value) {
                    return DropdownMenuItem<Pair>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (Pair? pair) {
                    if (pair != null) {
                      onChanged!(items.indexOf(pair));
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
