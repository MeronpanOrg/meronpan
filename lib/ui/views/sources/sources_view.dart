import 'package:flutter/material.dart';
import 'package:meronpan/sources/es/sources_es.dart';
import 'package:meronpan/sources/source_page.dart';

class SourcesView extends StatelessWidget {
  const SourcesView({Key? key}) : super(key: key);

  final List<SourcePage> sourcesPages = const [ExploreTmoView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fuentes')),
      body: ListView.builder(
        itemCount: sourcesPages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sourcesPages[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => sourcesPages[index] as Widget,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
