import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_icons.dart';
import '../../../shared/widgets/custom_icons2.dart';
import 'gallery_item.dart';
import 'gallery_view.dart';

class OneApApartmentGallery extends StatefulWidget {
  final List<String>? galleryImgs;

  const OneApApartmentGallery({super.key, this.galleryImgs});

  @override
  State<OneApApartmentGallery> createState() => _OneApApartmentGalleryState();
}

class _OneApApartmentGalleryState extends State<OneApApartmentGallery> {
  List<GalleryItem> galleryItems = <GalleryItem>[];
  ScrollController scrollController = ScrollController();
  bool leftScroll = false;
  bool rightScroll = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    if (widget.galleryImgs!.length < 3) {
      rightScroll = false;
    }
  }

  void openGallery(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryView(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  void _scrollListener() {
    if (scrollController.offset <= 0 && !scrollController.position.outOfRange) {
      setState(() {
        leftScroll = false;
      });
    } else if (scrollController.offset > 0 &&
        !scrollController.position.outOfRange) {
      setState(() {
        leftScroll = true;
      });
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        rightScroll = false;
      });
    } else {
      setState(() {
        rightScroll = true;
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final onePercentOfHeight = SizeConfig.heightMultiplier;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: onePercentOfHeight * 35.5,
          ),
          child: IconButton(
            icon: Icon(
              CustomIcons.arrow_left,
              size: 13 * curScaleFactor,
              color: !leftScroll
                  ? const Color.fromRGBO(188, 188, 188, 1)
                  : const Color.fromRGBO(255, 255, 255, 1),
            ),
            splashColor: const Color.fromRGBO(255, 255, 255, 0.0),
            highlightColor: const Color.fromRGBO(255, 255, 255, 0.0),
            onPressed: () {
              scrollController.animateTo(
                scrollController.offset - 50,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
              top: onePercentOfHeight * 34, left: 50.0, right: 50.0),
          height: onePercentOfHeight * 9,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              shrinkWrap: true,
              itemCount: widget.galleryImgs!.length,
              itemBuilder: (context, index) {
                if (!galleryItems.any((item) => item.id == index.toString())) {
                  galleryItems.add(
                    GalleryItem(
                      id: index.toString(),
                      resource: widget.galleryImgs![index],
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    openGallery(context, index);
                  },
                  child: Hero(
                    tag: index,
                    child: Container(
                      height: onePercentOfHeight * 9,
                      width: onePercentOfHeight * 9,
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 10,
                            cornerSmoothing: 1,
                          ),
                        ),
                        color: const Color.fromRGBO(129, 132, 138, 0.64),
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: 10,
                              cornerSmoothing: 1,
                            ),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.galleryImgs![index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: onePercentOfHeight * 35.5, right: 10.0),
          child: IconButton(
            icon: Icon(
              CustomIcons2.arrow_right,
              size: 13 * curScaleFactor,
              color: !rightScroll
                  ? const Color.fromRGBO(188, 188, 188, 1)
                  : const Color.fromRGBO(255, 255, 255, 1),
            ),
            splashColor: const Color.fromRGBO(255, 255, 255, 0.0),
            highlightColor: const Color.fromRGBO(255, 255, 255, 0.0),
            onPressed: () {
              scrollController.animateTo(
                scrollController.offset + 50,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
          ),
        ),
      ],
    );
  }
}
