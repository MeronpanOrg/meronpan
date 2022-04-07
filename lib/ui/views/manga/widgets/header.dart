import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meronpan/domain/sources/models/manga.dart';
import 'package:meronpan/ui/widgets/manga_cover.dart';

class Header extends StatelessWidget {
  final Manga manga;

  const Header({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                  manga.thumbnailUrl,
                ),
                fit: BoxFit.cover),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3.0,
                sigmaY: 3.0,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.white24],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  MangaCover(
                    manga: manga,
                    height: 200,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      manga.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
