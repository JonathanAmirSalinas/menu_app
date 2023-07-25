import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_app/model/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class BuildShoppingCart extends StatelessWidget {
  const BuildShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Drawer(
      width: 350,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildSideMenuHeader(context),
            cartProvider.cart.isEmpty
                ? Expanded(
                    child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.width * .9,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: const Align(
                            alignment: Alignment.center,
                            child: Text("Shopping Cart is Empty")),
                      ),
                    ],
                  ))
                : Expanded(
                    child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: cartProvider.cart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildCartItems(context, index);
                      },
                    ),
                  )),
            const SizedBox(
              height: 2,
            ),

            const Divider(
              color: Colors.white70,
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),

            // Display Total Price of all item in cart list
            cartProvider.cart.isEmpty
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width * 9,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Total: \$${cartProvider.total.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize),
                    )),

            Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * .08,
              width: MediaQuery.of(context).size.width * .9,
              child: buildCheckoutButton(context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildSideMenuHeader(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    //decoration: const BoxDecoration(color: Color.fromARGB(244, 35, 35, 35)),
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            "Shopping Cart",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          Divider(
            color: Colors.white70,
            thickness: 3,
          )
        ],
      ),
    ),
  );
}

Widget buildCartItems(BuildContext context, int index) {
  CartProvider cartProvider = Provider.of<CartProvider>(context);
  return Column(
    children: [
      Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height * .12,
                  width: MediaQuery.of(context).size.height * .16,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                          image:
                              AssetImage(cartProvider.cart[index].productImage),
                          fit: BoxFit.cover)),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          cartProvider.cart[index].product,
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      cartProvider.del(index);
                    },
                    splashRadius: 20,
                    icon: const Icon(Icons.highlight_remove_rounded)),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      cartProvider.increase(
                          cartProvider.quantity[index], index);
                    },
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.red,
                    )),
                Text(
                  cartProvider.quantity[index].toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                IconButton(
                    onPressed: () {
                      cartProvider.decrease(
                          cartProvider.quantity[index], index);
                    },
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.blue,
                    )),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${cartProvider.itemCost[index].toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const Divider(
        color: Colors.white70,
        thickness: 2,
        endIndent: 50,
      )
    ],
  );
}

Widget buildCheckoutButton(BuildContext context) {
  CartProvider cartProvider = Provider.of(context);
  return cartProvider.cart.isNotEmpty
      ? ElevatedButton(
          onPressed: () {
            context.go('/checkout');
          },
          child: const Text("Checkout"),
        )
      : ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Cart is Empty")));
            Scaffold.of(context).closeEndDrawer();
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Theme.of(context).disabledColor)),
          child: const Text("Checkout"),
        );
}
