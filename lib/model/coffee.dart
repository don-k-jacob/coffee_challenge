class Coffee {
  final String name;
  final String pathImage;
  final double price;

  const Coffee(this.name, this.pathImage, this.price);

  static const coffeeList = [
    Coffee('Caramel Cold Drink', 'assets/img/2.png', 3.2),
    Coffee('Iced Coffe Mocha', 'assets/img/3.png', 3.2),
    Coffee('Caramelized Pecan Latte', 'assets/img/4.png', 3.5),
    Coffee('Caramel Macchiato', 'assets/img/1.png', 3.2),
    Coffee('Toffee Nut Latte', 'assets/img/5.png', 3.9),
    Coffee('Capuchino', 'assets/img/6.png', 3.1),
    Coffee('Toffee Nut Iced Latte', 'assets/img/7.png', 4.0),
    Coffee('Classic Irish Coffee', 'assets/img/11.png', 4.3),
    Coffee('Black Tea Latte', 'assets/img/10.png', 4.3),
    Coffee('Toffee Nut Crunch Latte', 'assets/img/12.png', 3.7),
    Coffee('Americano', 'assets/img/8.png', 3.3),
    Coffee('Vietnamese Style Iced Coffee', 'assets/img/9.png', 4.2),
  ];
}
