import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_tracker/widgets/portfolio/assets_section.dart';
import 'package:crypto_tracker/widgets/portfolio/liabilities_section.dart';
import 'package:crypto_tracker/widgets/shared/net_worth_tile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/res/color.dart';


class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;
  final List<Widget> pages = [
    const AssetsSection(),
    const LiabilitiesSection()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          NetWorthTile(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: AppColors.cardColor.withOpacity(0.2),
              ),
              width: 100.w,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                child: Column(
                  children: [
                    CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          height: 45.h,
                          enableInfiniteScroll: false,
                          enlargeFactor: 3,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                        items: pages,
                        carouselController: _carouselController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: pages.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _carouselController
                              .animateToPage(entry.key, curve: Curves.easeInBack),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
