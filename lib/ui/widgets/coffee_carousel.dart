import 'dart:ui';

import 'package:coffee_challenge/model/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeCarousel extends StatelessWidget {
  const CoffeeCarousel({
    Key key,
    @required double percent,
    @required this.coffeeList,
    @required int index,
  })  : _percent = percent,
        _index = index,
        super(key: key);

  final double _percent;
  final List<Coffee> coffeeList;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return Stack(
          children: [
            // Last coffee
            if (_index > 1)
              Positioned(
                top: 0.0,
                bottom: lerpDouble((height * .4), (height * .6), _percent),
                left: lerpDouble(100, 150, _percent),
                right: lerpDouble(100, 150, _percent),
                child: Opacity(
                    opacity: 1.0 - _percent,
                    child: _CoffeeImage(
                      coffee: coffeeList[_index - 2],
                    )),
              ),

            // Second coffee
            if (_index > 0)
              Positioned(
                  top: lerpDouble((height * .08), 0, _percent),
                  bottom: lerpDouble((height * .2), (height * .4), _percent),
                  right: lerpDouble(50, 100, _percent),
                  left: lerpDouble(50, 100, _percent),
                  child: _CoffeeImage(
                    coffee: coffeeList[_index - 1],
                  )),

            // Third coffee
            Positioned(
              top: lerpDouble((height * .18), (height * .08), _percent),
              bottom: lerpDouble((height * .02), (height * .2), _percent),
              right: lerpDouble(20, 50, _percent),
              left: lerpDouble(20, 50, _percent),
              child: _CoffeeImage(
                coffee: coffeeList[_index],
              ),
            ),

            // Hide bottom coffee
            Positioned.fill(
              top: lerpDouble(height, height * .18, _percent),
              bottom: lerpDouble(-(height * .4), (height * .02), _percent),
              right: lerpDouble(0, 20, _percent),
              left: lerpDouble(0, 20, _percent),
              child: _CoffeeImage(
                coffee:
                    coffeeList[(_index + 1).clamp(0, coffeeList.length - 1)],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CoffeeImage extends StatelessWidget {
  final Coffee coffee;

  const _CoffeeImage({Key key, @required this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      coffee.pathImage,
      fit: BoxFit.contain,
    );
  }
}
