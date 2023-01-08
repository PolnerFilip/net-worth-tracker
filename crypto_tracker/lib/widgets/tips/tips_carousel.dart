import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_tracker/widgets/carousel_location.dart';
import 'package:crypto_tracker/widgets/tips/tip.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TipCarousel extends StatelessWidget {
  const TipCarousel(
      {Key? key,
        required this.tips,
        required this.carouselController,
        required this.onPageChanged,
        required this.current})
      : super(key: key);

  final List<Tip> tips;
  final CarouselController carouselController;
  final dynamic onPageChanged;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 120),
            child: Column(
              children: [
                CarouselSlider(
                  items: tips,
                  carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    height: 45.h,
                    enableInfiniteScroll: false,
                    enlargeFactor: 3,
                    onPageChanged: onPageChanged,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: CarouselLocation(
                    content: tips,
                    carouselController: carouselController,
                    current: current,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
