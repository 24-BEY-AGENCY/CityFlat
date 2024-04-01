import 'package:cityflat/presentation/shared/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../utilities/size_config.dart';
import 'gallery_item.dart';

class GalleryView extends StatefulWidget {
  static const routeName = "/GalleryView";

  GalleryView({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryItem>? galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryViewState();
  }
}

class _GalleryViewState extends State<GalleryView> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final mediaQueryHeight = mediaQuery.size.height;
    final bigPhoneCheck = mediaQueryHeight >= 600;
    final onePercentOfHeight = SizeConfig.heightMultiplier;
    final onePercentOfWidth = SizeConfig.widthMultiplier;

    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems!.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: onePercentOfHeight * 6, left: onePercentOfWidth * 3),
              child: Container(
                margin: EdgeInsets.only(
                    left: 10.0,
                    bottom: bigPhoneCheck
                        ? onePercentOfHeight * 5
                        : onePercentOfHeight * 7),
                child: CustomBackButton(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryItem item = widget.galleryItems![index];

    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item.resource!),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
