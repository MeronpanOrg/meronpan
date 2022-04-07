import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meronpan/domain/sources/models/manga.dart';

class MangaCover extends StatelessWidget {
  const MangaCover(
      {Key? key, required this.manga, this.height = 170, this.width = 135})
      : super(key: key);

  final Manga manga;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: manga.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
