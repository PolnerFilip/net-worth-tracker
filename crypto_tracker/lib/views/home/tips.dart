import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_tracker/services/tips_service.dart';
import 'package:crypto_tracker/widgets/shared/net_worth_tile.dart';
import 'package:crypto_tracker/widgets/tips/tip.dart';
import 'package:crypto_tracker/widgets/tips/tips_carousel.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        const NetWorthTile(),
        TipsService.persistentTips.isNotEmpty
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
              ),
      ],
    );
  }
}