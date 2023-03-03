import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/model/providers/cart_provider.dart';
import 'package:provider/provider.dart';

buildPromotionMenu(BuildContext context, PageController controller) {
  return SingleChildScrollView(
    child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width * .9,
          child: PageView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return buildPromotionMenuItems(context);
              }),
        )),
  );
}

buildPromotionMenuItems(BuildContext context) {
  CartProvider cartProvider = Provider.of<CartProvider>(context);
  return GestureDetector(
    onTap: () {
      cartProvider.add("Chips", "Chips that are good", "Chips", "Snacks", "",
          "pid", 7.99, "Chips", "Chips");
    },
    child: Center(
      child: Column(
        children: [
          Card(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width * .8,
              child: Stack(
                children: [
                  Align(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .4,
                      width: MediaQuery.of(context).size.width * .8,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: const Text("IMAGE URL"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        padding: const EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.width * .65,
                        decoration: const BoxDecoration(color: Colors.black54),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Title",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70),
                            ),
                            Text(
                              "   Sub-Title",
                              style: TextStyle(
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
Widget buildMenuCard(BuildContext context, String itemTitle) {
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
                width: 240,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text("IMAGE URL"),
              ),
            ),
            ExpansionTile(
              tilePadding: const EdgeInsets.all(45),
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(itemTitle, style: const TextStyle(fontSize: 28)),
              ),
              children: <Widget>[
                buildMenuItemCard(context),
                buildMenuItemCard(context),
              ],
            ),
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
buildMenuItemCard(BuildContext context) {
  CartProvider cartProvider = Provider.of<CartProvider>(context);
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: GestureDetector(
      onTap: () {
        cartProvider.add("Chips", "Chips that are good", "Chips", "Snacks", "",
            "pid", 7.99, "Chips", "Chips");
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
                            height: MediaQuery.of(context).size.height * .15,
                            width: 160,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: const Text("IMAGE URL"),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                width: MediaQuery.of(context).size.width > 500
                                    ? MediaQuery.of(context).size.width * .4
                                    : 200,
                                decoration:
                                    const BoxDecoration(color: Colors.black54),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Title",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70),
                                    ),
                                    Text(
                                      "   Sub-Title",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          "INFO",
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
    ),
  );
}
