import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/model/item_model.dart';
import 'package:menu_app/model/providers/cart_provider.dart';
import 'package:menu_app/model/providers/menu_provider.dart';
import 'package:provider/provider.dart';

// Pass Promotion List (From Provider or List Object)
buildPromotionMenu(BuildContext context, PageController controller) {
  MenuProvider menuProvider = Provider.of<MenuProvider>(context);
  return SingleChildScrollView(
    child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SizedBox(
          height: 420,
          width: MediaQuery.of(context).size.width * .9,
          child: PageView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: menuProvider.promotionMenu.length,
              itemBuilder: (BuildContext context, int index) {
                return buildPromotionMenuItems(
                    context, menuProvider.promotionMenu[index]);
              }),
        )),
  );
}

buildPromotionMenuItems(BuildContext context, ItemModel item) {
  return GestureDetector(
    onTap: () {
      showMenuItemInfo(context, item);
    },
    child: Center(
      child: Column(
        children: [
          Card(
            child: SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width * .8,
              child: Stack(
                children: [
                  Align(
                    child: Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width * .8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(item.productImage),
                              fit: BoxFit.cover),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        padding: const EdgeInsets.all(8),
                        height: 80,
                        width: 650,
                        decoration: const BoxDecoration(color: Colors.black54),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70),
                            ),
                            Text(
                              item.description,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70),
                            ),
                          ],
                        )),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "PROMOTION TYPE",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Generate Main Expandable Items From Stream/Future
Widget buildMenuCard(BuildContext context, String itemTitle,
    String itemMenuMain, List<ItemModel> itemMenu) {
  return Column(
    children: [
      Container(
        //margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width < 500 ? 160 : 240,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(itemMenuMain), fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
              ),
            ),
            ExpansionTile(
                tilePadding: const EdgeInsets.all(45),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(itemTitle,
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .fontSize)),
                ),
                children: itemMenu
                    .map((item) => buildMenuItemCard(context, item))
                    .toList()),
          ],
        ),
      ),
      const Divider(
        color: Colors.black12,
        thickness: 4,
      ),
    ],
  );
}

// Item
Widget buildMenuItemCard(BuildContext context, ItemModel item) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: GestureDetector(
      onTap: () {
        showMenuItemInfo(context, item);
      },
      child: Center(
        child: Column(
          children: [
            Card(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .15,
                width: MediaQuery.of(context).size.width * .8,
                child: Stack(
                  children: [
                    Align(
                      child: Row(
                        children: [
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width < 500
                                ? 120
                                : 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(item.productImage),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4))),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                height: MediaQuery.of(context).size.height * .1,
                                width: MediaQuery.of(context).size.width > 500
                                    ? MediaQuery.of(context).size.width * .4
                                    : MediaQuery.of(context).size.width < 500
                                        ? 160
                                        : 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Item Info Widget (Bottom Sheet)
void showMenuItemInfo(BuildContext context, ItemModel item) {
  CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
  showModalBottomSheet(
      context: context,
      builder: ((context) {
        return FractionallySizedBox(
          heightFactor: 1.8,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: Theme.of(context).canvasColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Item Menu Category
                          Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(left: 4),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Colors.white54),
                              child: Text(item.category,
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .fontSize))),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ITem Image
                          Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width < 500
                                ? 160
                                : 240,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(item.productImage),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                          ),
                          SizedBox(
                            height: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Item Name Text
                                Flexible(
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        item.product,
                                        style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .fontSize),
                                        overflow: TextOverflow.visible,
                                      )),
                                ),
                                // Item Price Text
                                Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                        'Price: \$ ${item.price.toString()}',
                                        style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .fontSize))),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add to Cart Button
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: TextButton.icon(
                              onPressed: () {
                                cartProvider.add(item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Item was added to Cart")));
                              },
                              icon: const Icon(
                                  Icons.shopping_cart_checkout_rounded),
                              label: const Text('Add to Cart')),
                        ),
                        // Item Info
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Description Label
                                Text('Description: ',
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .fontSize)),
                                // Item Info
                                Text(item.description,
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize)),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }));
}
