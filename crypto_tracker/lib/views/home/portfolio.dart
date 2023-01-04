import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/widgets/portfolio/assets_section.dart';
import 'package:crypto_tracker/widgets/portfolio/liabilities_section.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 35.h,
            width: 100.w,
            child: Stack(
              children: [
                Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                      gradient: AppColors.getDarkLinearGradient(Colors.indigo),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      )),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Holding Portfolio",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.7,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "\$ 231.223",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.2,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                Icons.arrow_upward_rounded,
                                size: 14,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "\$ 5.10",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.2),
            ),
            width: 90.w,
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
        ],
      ),
    );
  }
}
