import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/core/utils/status_enum.dart';
import 'package:meronpan/presentation/widgets/manga_cover.dart';

class Header extends StatelessWidget {
  final Manga manga;

  const Header({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: MangaCover(
                      manga: manga,
                      height: 200,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 230,
                            child: Tooltip(
                              message: manga.title,
                              child: Text(
                                manga.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            manga.author,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            manga.status.displayTitle,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
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

  Container _buildBackground() {
    return Container(
      width: double.infinity,
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
    );
  }
}
