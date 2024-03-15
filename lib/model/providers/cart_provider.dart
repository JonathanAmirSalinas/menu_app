import 'package:flutter/material.dart';
import 'package:menu_app/model/item_model.dart';

class CartProvider with ChangeNotifier {
  List<ItemModel> cart = [];
  List<int> quantity = [];
  List<double> itemCost = [];
  double total = 0;

  // Adds item to cart and quanity list
  add(ItemModel item) {
    cart.add(item);

    quantity.add(1);
    itemCost.add(item.price);
    total += item.price;

    notifyListeners();
  }

  // Deletes item from item list and quantity list using index
  del(int index) {
    total -= itemCost[index];
    cart.removeAt(index);
    quantity.removeAt(index);
    itemCost.removeAt(index);
    notifyListeners();
  }

  //Increases item quantity
  increase(int currentQuantity, int index) {
    quantity[index] = currentQuantity + 1;
    itemCost[index] += cart[index].price;
    total += cart[index].price;
    notifyListeners();
  }

  // If 0 delete item from cart / else decrease item quantity
  decrease(int currentQuantity, int index) {
    if (currentQuantity == 1) {
      del(index);
    } else {
      quantity[index] = currentQuantity - 1;
      itemCost[index] -= cart[index].price;
      total -= cart[index].price;
    }
    notifyListeners();
  }

  // Clears item off or user's cart
  clear() {
    cart.clear();
    quantity.clear();
    itemCost.clear();
    total = 0;
    notifyListeners();
  }
}
