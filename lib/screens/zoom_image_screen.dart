import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../components/back_widget.dart';
import '../components/loader_widget.dart';

class ZoomImageScreen extends StatefulWidget {
  final int index;
  final List<String>? galleryImages;

  ZoomImageScreen({required this.index, this.galleryImages});

  @override
  _ZoomImageScreenState createState() => _ZoomImageScreenState();
}

class _ZoomImageScreenState extends State<ZoomImageScreen> {
  bool showAppBar = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    enterFullScreen();
  }

  @override
  void dispose() {
    exitFullScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exitFullScreen();

        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: scaffoldDarkColor,
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: BouncingScrollPhysics(),
              enableRotation: false,
              backgroundDecoration: BoxDecoration(color: scaffoldDarkColor),
              pageController: PageController(initialPage: widget.index),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: Image.network(widget.galleryImages![index], errorBuilder: (context, error, stackTrace) => PlaceHolderWidget()).image,
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered,
                  errorBuilder: (context, error, stackTrace) => PlaceHolderWidget(),
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: widget.galleryImages![index],
                  ),
                );
              },
              itemCount: widget.galleryImages!.length,
              loadingBuilder: (context, event) => LoaderWidget(color: Colors.white),
            ),
            Positioned(
              top: context.statusBarHeight + 16,
              left: 8,
              child: BackWidget(
                onPressed: () {
                  exitFullScreen();
                  finish(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
