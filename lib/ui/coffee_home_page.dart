import 'dart:ui';

import 'package:coffee_challenge/model/coffee.dart';
import 'package:coffee_challenge/ui/coffee_list_page.dart';
import 'package:coffee_challenge/ui/widgets/coffee_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoffeeHomePage extends StatelessWidget {
  void _openCoffeeListPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(opacity: animation, child: CoffeeListPage());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final coffeeList = Coffee.coffeeList;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //--------------------------
          // Gradient Background
          //--------------------------
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0, -.3),
                colors: [Colors.brown, Colors.white],
              ),
            ),
          ),
          Column(
            children: [
              const CoffeeAppBar(brightness: Brightness.light),
              //----------------------
              // Coffee Images
              //----------------------
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final height = constraints.maxHeight;
                    return GestureDetector(
                      onTap: () => _openCoffeeListPage(context),
                      onVerticalDragUpdate: (details) => _openCoffeeListPage(context),
                      child: Stack(
                        children: [
                          _CoffeeTransformedItem(
                            displacement: 0,
                            scale: .4,
                            endTransitionOpacity: .5,
                            coffee: coffeeList[0],
                          ),
                          _CoffeeTransformedItem(
                            displacement: height * .1,
                            scale: 1.1,
                            endTransitionOpacity: .8,
                            coffee: coffeeList[1],
                          ),
                          _CoffeeTransformedItem(
                            displacement: height * .23,
                            scale: 1.45,
                            isOverflowed: true,
                            coffee: coffeeList[2],
                          ),
                          Align(
                            alignment: Alignment(0, .35),
                            child: Text.rich(
                              TextSpan(
                                text: 'Frika',
                                children: [
                                  TextSpan(
                                    text: '\nCoffee',
                                    style: GoogleFonts.poppins(
                                      height: 1.0,
                                      fontSize: 60,
                                    ),
                                  )
                                ],
                              ),
                              style: GoogleFonts.lilitaOne(
                                fontSize: 70,
                                color: Colors.white.withOpacity(.9),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          _CoffeeTransformedItem(
                            displacement: height * .75,
                            scale: 1.75,
                            isOverflowed: true,
                            coffee: coffeeList[3],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _CoffeeTransformedItem extends StatelessWidget {
  const _CoffeeTransformedItem({
    Key key,
    @required this.displacement,
    @required this.coffee,
    this.endTransitionOpacity = 1.0,
    this.scale = 1.0,
    this.isOverflowed = false,
  }) : super(key: key);

  final double displacement;
  final double scale;
  final bool isOverflowed;
  final double endTransitionOpacity;
  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, displacement),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.topCenter,
        child: AspectRatio(
          aspectRatio: .85,
          child: Hero(
            tag: coffee.name,
            flightShuttleBuilder: (_, animation, __, ___, ____) {
              return AnimatedBuilder(
                animation: animation,
                builder: (_, child) {
                  final fixedScale = (scale * .85);
                  return Transform.scale(
                    scale: isOverflowed
                        ? lerpDouble(fixedScale, 1.0, animation.value)
                        : 1.0,
                    child: Opacity(
                      opacity: lerpDouble(
                        1.0,
                        endTransitionOpacity,
                        animation.value,
                      ),
                      child: child,
                    ),
                  );
                },
                child: Image.asset(coffee.pathImage),
              );
            },
            child: Image.asset(coffee.pathImage),
          ),
        ),
      ),
    );
  }
}
