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
                return buildMenu(context);
              }),
        )),
  );
}

buildMenu(BuildContext context) {
  CartProvider cartProvider = Provider.of<CartProvider>(context);
  return GestureDetector(
    onTap: () {
      cartProvider.add("Chips", "Chips that are good", "Chips", "Snacks", "",
          "pid", 5, "Chips", "Chips");
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
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
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
                        "Date",
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
