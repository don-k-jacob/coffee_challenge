import 'package:coffee_challenge/model/coffee.dart';
import 'package:coffee_challenge/ui/widgets/coffee_carousel.dart';
import 'package:flutter/material.dart';

class CoffeeListPage extends StatefulWidget {
  const CoffeeListPage({
    Key key,
  }) : super(key: key);

  @override
  _CoffeeListPageState createState() => _CoffeeListPageState();
}

class _CoffeeListPageState extends State<CoffeeListPage> {
  PageController _sliderPageController;
  PageController _titlePageController;
  int _index;
  double _percent;

  @override
  void initState() {
    _index = 2;
    _sliderPageController = PageController(initialPage: _index);
    _titlePageController = PageController(initialPage: _index);
    _percent = 0.0;
    _sliderPageController.addListener(_pageListener);
    super.initState();
  }

  @override
  void dispose() {
    _sliderPageController.removeListener(_pageListener);
    _sliderPageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    _index = _sliderPageController.page.floor();
    _percent = (_sliderPageController.page - _index).abs();
    _titlePageController.position
        .jumpTo(_sliderPageController.page * MediaQuery.of(context).size.width);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final coffeeList = Coffee.coffeeList;
    return Scaffold(
      body: Column(
        children: [
          const _CustomAppBar(),
          //------------------------
          // Coffee names
          //------------------------
          SizedBox(
            height: MediaQuery.of(context).size.height * .15,
            child: PageView.builder(
              itemCount: coffeeList.length,
              physics: const BouncingScrollPhysics(),
              controller: _titlePageController,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: _TitleCoffee(coffee: coffeeList[index]),
                );
              },
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                //------------------------------
                // Gradient background
                //------------------------------
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.75, 1.0],
                      colors: [
                        Colors.white,
                        Colors.deepOrange[200],
                      ],
                    )),
                  ),
                ),
                //--------------------------------
                // Animated Coffee Images
                //--------------------------------
                CoffeeCarousel(
                  percent: _percent,
                  coffeeList: coffeeList,
                  index: _index,
                ),
                //--------------------------------
                // Void page view
                //--------------------------------
                PageView.builder(
                  controller: _sliderPageController,
                  itemCount: coffeeList.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TitleCoffee extends StatelessWidget {
  const _TitleCoffee({
    Key key,
    @required this.coffee,
  }) : super(key: key);

  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          coffee.name,
          style: Theme.of(context).textTheme.headline5,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        Text(
          "${coffee.price} US",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                iconSize: 32,
                icon: Icon(Icons.shopping_bag_outlined),
                onPressed: () {},
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
