import 'dart:ui';

import 'package:coffee_challenge/model/coffee.dart';
import 'package:flutter/cupertino.dart';
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
          alignment: Alignment.center,
          children: [
            // Third coffee
            if (_index > 1)
              Transform.scale(
                scale: lerpDouble(.3, 0, _percent),
                alignment: Alignment.topCenter,
                child: Opacity(
                    opacity: 1.0 - _percent,
                    child: _CoffeeImage(
                      coffee: coffeeList[_index - 2],
                    )),
              ),

            // Second coffee
            if (_index > 0)
              Transform.translate(
                offset: Offset(0, lerpDouble((height * .1), 0, _percent)),
                child: Transform.scale(
                  scale: lerpDouble(.6, .3, _percent),
                  alignment: Alignment.topCenter,
                  child: _CoffeeImage(
                    coffee: coffeeList[_index - 1],
                  ),
                ),
              ),

            // First coffee
            Transform.translate(
              offset: Offset(
                  0, lerpDouble((height * .25), (height * .1), _percent)),
              child: Transform.scale(
                scale: lerpDouble(1.0, .6, _percent),
                alignment: Alignment.topCenter,
                child: _CoffeeImage(
                  coffee: coffeeList[_index],
                ),
              ),
            ),

            // Hide bottom coffee
            if (_index < coffeeList.length - 1)
              Transform.translate(
                offset: Offset(
                    0, lerpDouble(height * 1.5, (height * .25), _percent)),
                child: Transform.scale(
                  alignment: Alignment.center,
                  scale: lerpDouble(2.0, 1.0, _percent),
                  child: _CoffeeImage(
                    coffee: coffeeList[_index + 1],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CoffeeImage extends StatelessWidget {
  const _CoffeeImage({
    Key key,
    @required this.coffee,
  }) : super(key: key);
  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AspectRatio(
        aspectRatio: 0.85,
        child: Hero(
          tag: coffee.name,
          child: Image.asset(
            coffee.pathImage,
          ),
        ),
      ),
    );
  }
}
