import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:crypto_tracker/services/tips_service.dart';
import 'package:crypto_tracker/widgets/carousel_location.dart';
import 'package:crypto_tracker/widgets/tips/tip.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({Key? key}) : super(key: key);

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  int _current = 0;
  bool isLoading = false;
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
    return FutureBuilder<List<Tip>>(
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
            return Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        isLoading
                            ? const Text("Loading...")
                            : CarouselSlider(
                                items: snapshot.data,
                                carouselController: _carouselController,
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
                              ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: CarouselLocation(
                            content: snapshot.data!,
                            carouselController: _carouselController,
                            current: _current,
                          ),
                        ),
                        TextButton(
                            onPressed: getTips, child: const Text("Test"))
                      ],
                    ),
                  ),
                ),
              ],
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
