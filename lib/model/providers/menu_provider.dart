import 'package:flutter/material.dart';
import 'package:menu_app/model/item_model.dart';

class MenuProvider with ChangeNotifier {
  List<ItemModel> promotionMenu = [
    const ItemModel(
        product: "Breakfast Combo",
        description: 'Combo',
        category: 'Promotional Breakfast',
        menu: 'Promotion',
        price: 15.99,
        pid: '001',
        productImage: 'lib/assets/full_breakfast_set.jpg'),
    const ItemModel(
        product: "Lunch Combo",
        description: 'Combo',
        category: 'Promotional Lunch',
        menu: 'Promotion',
        price: 12.99,
        pid: '002',
        productImage: 'lib/assets/8pc_wings.jpg')
  ];
  List<ItemModel> lunchMenu = [
    const ItemModel(
        product: "Burger and Fries",
        description:
            'Beef Burger with chesse, lettuce, tomato and pickles. Comes with a 16 oz beverage of choice and a side of fries.',
        category: 'Lunch',
        menu: 'Lunch',
        price: 11.99,
        pid: '003',
        productImage: 'lib/assets/burger_and_fries.jpg'),
    const ItemModel(
        product: "Fish and Fries",
        description: 'Fried Fish and a side of fries.',
        category: 'Lunch',
        menu: 'Lunch',
        price: 9.99,
        pid: '004',
        productImage: 'lib/assets/fish_and_chips.jpg'),
  ];
  List<ItemModel> breakfastMenu = [
    const ItemModel(
        product: "Blueberry Pancakes",
        description: '4 fluffy blueberry pancakes.',
        category: 'Breakfast',
        menu: 'Breakfast',
        price: 10.99,
        pid: '005',
        productImage: 'lib/assets/blueberry_pancakes.jpg'),
    const ItemModel(
        product: "Cinnamon Rolls",
        description: '2 freashly baked cinnamon rolls',
        category: 'Breakfast',
        menu: 'Breakfast',
        price: 7.99,
        pid: '006',
        productImage: 'lib/assets/cinnamon_rolls.jpg'),
  ];
  List<ItemModel> snacksMenu = [
    const ItemModel(
        product: "Blueberry Muffins",
        description: '2 blueberry muffins',
        category: 'Snacks',
        menu: 'Snacks',
        price: 2.99,
        pid: '007',
        productImage: 'lib/assets/blueberry_muffins.jpg'),
    const ItemModel(
        product: "Churros",
        description: '2 churros',
        category: 'Snacks',
        menu: 'Snacks',
        price: 1.99,
        pid: '008',
        productImage: 'lib/assets/churros.jpg'),
    const ItemModel(
        product: "Chocolate Muffins",
        description: '2 chocolate muffins',
        category: 'Snacks',
        menu: 'Snacks',
        price: 3.99,
        pid: '009',
        productImage: 'lib/assets/chocolate_muffin.jpg'),
  ];
  List<ItemModel> drinksMenu = [
    const ItemModel(
        product: "Lemonade",
        description: '16oz Lemonade',
        category: 'Drinks',
        menu: 'Drinks',
        price: 2.99,
        pid: '010',
        productImage: 'lib/assets/lemonade.jpg'),
  ];

  addPromotionMenu(ItemModel item) {
    promotionMenu.add(item);
    notifyListeners();
  }

  addLunchMenu(ItemModel item) {
    lunchMenu.add(item);
    notifyListeners();
  }

  addBreakfastMenu(ItemModel item) {
    breakfastMenu.add(item);
    notifyListeners();
  }

  addSnacksMenu(ItemModel item) {
    snacksMenu.add(item);
    notifyListeners();
  }

  addDrinksMenu(ItemModel item) {
    drinksMenu.add(item);
    notifyListeners();
  }
}
