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
                scale: lerpDouble(.4, 0, _percent),
                alignment: Alignment.topCenter,
                child: Opacity(
                    opacity: 1.0 - _percent,
                    child: _CoffeeImage(
                      parentSize: constraints.biggest,
                      coffee: coffeeList[_index - 2],
                    )),
              ),

            // Second coffee
            if (_index > 0)
              Transform.translate(
                offset: Offset(0, lerpDouble((height * .1), 0, _percent)),
                child: Transform.scale(
                  scale: lerpDouble(.7, .4, _percent),
                  alignment: Alignment.topCenter,
                  child: _CoffeeImage(
                    parentSize: constraints.biggest,
                    coffee: coffeeList[_index - 1],
                  ),
                ),
              ),

            // First coffee
            Transform.translate(
              offset: Offset(
                  0, lerpDouble((height * .25), (height * .1), _percent)),
              child: Transform.scale(
                scale: lerpDouble(1.0, .7, _percent),
                alignment: Alignment.topCenter,
                child: _CoffeeImage(
                  parentSize: constraints.biggest,
                  coffee: coffeeList[_index],
                ),
              ),
            ),

            // Hide bottom coffee
            Transform.translate(
              offset:
                  Offset(0, lerpDouble(height * 1.3, (height * .25), _percent)),
              child: Transform.scale(
                alignment: Alignment.center,
                scale: lerpDouble(1.5, 1.0, _percent),
                child: _CoffeeImage(
                  parentSize: constraints.biggest,
                  coffee:
                      coffeeList[(_index + 1).clamp(0, coffeeList.length - 1)],
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
    @required this.parentSize,
  }) : super(key: key);
  final Coffee coffee;
  final Size parentSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: parentSize.height * .7,
        width: parentSize.width * .9,
        child: Image.asset(coffee.pathImage, fit: BoxFit.fill,),
      ),
    );
  }
}
