import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_tracker/services/tips_service.dart';
import 'package:crypto_tracker/widgets/carousel_location.dart';
import 'package:crypto_tracker/widgets/tips/tip.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({Key? key}) : super(key: key);

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  int _current = 0;
  final CarouselController _carouselController = CarouselController();
  final TipsService tipsService = TipsService.instance;
  late Future<List<Tip>> _tips;

  @override
  void initState() {
    getTips();
    super.initState();
  }

  getTips() async {
    _tips = tipsService.getTips();
  }

  @override
  Widget build(BuildContext context) {
    return TipsService.persistentTips.isNotEmpty
        ? TipCarousel(
            tips: TipsService.persistentTips,
            carouselController: _carouselController,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            current: _current,
          )
        : FutureBuilder<List<Tip>>(
            future: _tips,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<Tip>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return TipCarousel(
                    tips: snapshot.data!,
                    carouselController: _carouselController,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    current: _current,
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          );
  }
}

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
            margin: const EdgeInsets.only(top: 50),
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
