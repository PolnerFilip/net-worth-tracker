import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselLocation extends StatelessWidget {
  const CarouselLocation({
    Key? key,
    required this.content,
    required CarouselController carouselController,
    required int current,
  })  : _carouselController = carouselController,
        _current = current,
        super(key: key);

  final List<Widget> content;
  final CarouselController _carouselController;
  final int _current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: content.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _carouselController.animateToPage(entry.key,
              curve: Curves.easeInBack),
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }
}
