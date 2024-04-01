import 'dart:io';

import 'package:flutter/widgets.dart';

class GalleryItem {
  GalleryItem({
    required this.id,
    this.resource,
    this.resourceFile,
    this.isSvg = false,
  });

  final String id;
  final String? resource;
  final File? resourceFile;
  final bool isSvg;
}

class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({
    Key? key,
    required this.galleryItem,
    required this.onTap,
  }) : super(key: key);

  final GalleryItem galleryItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryItem.id,
          child: Image.network(galleryItem.resource!, height: 80.0),
        ),
      ),
    );
  }
}
