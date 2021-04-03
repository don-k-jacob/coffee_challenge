import 'package:coffee_challenge/model/coffee.dart';
import 'package:coffee_challenge/ui/widgets/coffee_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoffeeOrderPage extends StatelessWidget {
  const CoffeeOrderPage({Key key, this.coffee}) : super(key: key);
  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const CoffeeAppBar(),
          //------------------------
          // Coffee name
          //------------------------
          SizedBox(
            width: size.width * .65,
            child: Hero(
              tag: coffee.name + "title",
              child: Text(
                coffee.name,
                style: Theme.of(context).textTheme.headline5,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //------------------------
          // Coffee Image
          //------------------------
          Expanded(
            flex: 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  top: 20.0,
                  child: Hero(
                    tag: coffee.name,
                    child: Image.asset(coffee.pathImage),
                  ),
                ),
                Align(
                  alignment: Alignment(-.7, .8),
                  //-----------------------------
                  // Text price animated
                  //-----------------------------
                  child: TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 600),
                    tween: Tween(begin: 1.0, end: 0.0),
                    curve: Curves.fastOutSlowIn,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(-(size.width * .5) * value,
                            (size.height * .4) * value),
                        child: child,
                      );
                    },
                    child: Text(
                      "${coffee.price}\$",
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.white, shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 30,
                        )
                      ]),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(.7, -.7),
                  //-----------------------------
                  // Add Button Animated
                  //-----------------------------
                  child: TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 600),
                    tween: Tween(begin: 1.0, end: 0.0),
                    curve: Curves.fastOutSlowIn,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset((size.width * .3) * value, 0),
                        child: Transform.rotate(
                          angle: 4.28 * value,
                          child: child,
                        ),
                      );
                    },
                    child: FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      elevation: 10,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.brown[700],
                      child: Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
          ),
          //------------------------
          // Coffee Sizes
          //------------------------
          Expanded(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.fastOutSlowIn,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, (size.height * .2) * value),
                  child: child,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: _CoffeeSizeOption(
                      isSelected: index == 1,
                      labelSize: ['s', 'm', 'b'][index],
                      onTap: () {},
                    ),
                  );
                }),
              ),
            ),
          ),
          //------------------------
          // Coffee temperatures
          //------------------------
          Expanded(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.fastOutSlowIn,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, (size.height * .2) * value),
                  child: child,
                );
              },
              child: const _CoffeeTemperatures(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoffeeTemperatures extends StatelessWidget {
  const _CoffeeTemperatures({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 10, offset: Offset(3, 10))
            ]),
            child: Text(
              'Hot | Warm',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.brown[700]),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Cold | Ice',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.grey[400]),
            ),
          ),
        ),
      ],
    );
  }
}

class _CoffeeSizeOption extends StatelessWidget {
  const _CoffeeSizeOption({
    Key key,
    @required this.isSelected,
    @required this.labelSize,
    @required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String labelSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isSelected
              ? [Colors.brown, Colors.orange]
              : [Colors.grey[300], Colors.grey[300]],
        ).createShader(bounds),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/$labelSize-coffee-cup.svg",
              width: 45.0,
              color: Colors.white,
            ),
            Text(
              labelSize.toUpperCase(),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
