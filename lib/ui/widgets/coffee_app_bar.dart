import 'package:flutter/material.dart';

class CoffeeAppBar extends StatelessWidget {
  const CoffeeAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (Navigator.canPop(context)) Navigator.pop(context);
              },
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
      ),
    );
  }
}
