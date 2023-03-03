import 'package:flutter/material.dart';
import 'package:menu_app/model/providers/cart_provider.dart';
import 'package:menu_app/widgets/menu_items_widget.dart';
import 'package:menu_app/widgets/navigation_drawer.dart';
import 'package:menu_app/widgets/shopping_cart_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
            child: constraints.maxWidth < 500 || constraints.maxWidth == 500
                ? buildSmallMenu(context)
                : constraints.maxWidth > 1280
                    ? buildLargeMenu(context, constraints.maxWidth)
                    : buildMediumMenu(context, constraints.maxWidth));
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////// Small Window Widget /////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  buildSmallMenu(BuildContext context) {
    final pageController = PageController(viewportFraction: .8);
    return Scaffold(
        drawer: const NavigationDrawer(),
        endDrawer: const BuildShoppingCart(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                stretch: true,
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.dehaze_rounded),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                title: Text(
                  "Small",
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize),
                ),

                actions: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height * .1,
                                width: MediaQuery.of(context).size.width * .3,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).focusColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                // TEXTFIELD
                                child: const TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      hintText: "Search...",
                                      icon: Icon(
                                        Icons.search,
                                        size: 24,
                                      )),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                      splashRadius: 20,
                    ),
                  )
                ],
                //expandedHeight: 200,
              )
            ];
          },
          body: Row(
            children: [
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Text(
                          "Promotion",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontSize),
                        ),
                        const Divider(
                          thickness: 2,
                          endIndent: 50,
                        ),
                        buildPromotionMenu(context, pageController),
                        Text(
                          "Menu",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontSize),
                        ),
                        const Divider(
                          thickness: 2,
                          endIndent: 50,
                        ),
                        buildMenuCard(context, "Lunch"),
                        buildMenuCard(context, "Breakfast"),
                        buildMenuCard(context, "Snacks"),
                        buildMenuCard(context, "Drinks"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////// Medium Window Widget ////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  buildMediumMenu(BuildContext context, double windowSize) {
    final pageController = PageController(keepPage: true, viewportFraction: .6);
    return Scaffold(
        drawer: const NavigationDrawer(),
        endDrawer: const BuildShoppingCart(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                stretch: true,
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.dehaze_rounded),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                title: Text(
                  "Medium",
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize),
                ),

                actions: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text("Locations"),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text("Menu"),
                              ),
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                width: MediaQuery.of(context).size.width * .3,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).focusColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                // TEXTFIELD
                                child: const TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      hintText: "Search...",
                                      icon: Icon(
                                        Icons.search,
                                        size: 24,
                                      )),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  windowSize < 1280
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: IconButton(
                            onPressed: () {
                              if (windowSize > 1280) {
                                Scaffold.of(context).closeEndDrawer();
                              }

                              Scaffold.of(context).openEndDrawer();
                            },
                            icon: const Icon(Icons.shopping_cart_outlined),
                            splashRadius: 20,
                          ),
                        )
                      : Container(),
                ],
                //expandedHeight: 200,
              )
            ];
          },
          body: Row(
            children: [
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .05,
                          ),
                          Text(
                            "Promotion",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .fontSize),
                          ),
                          const Divider(
                            thickness: 2,
                            endIndent: 50,
                          ),
                          buildPromotionMenu(context, pageController),
                          Text(
                            "Menu",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .fontSize),
                          ),
                          const Divider(
                            thickness: 2,
                            endIndent: 50,
                          ),
                          buildMenuCard(context, "Lunch"),
                          buildMenuCard(context, "Breakfast"),
                          buildMenuCard(context, "Snacks"),
                          buildMenuCard(context, "Drinks"),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////// Large Window Widget /////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  buildLargeMenu(BuildContext context, double windowSize) {
    final pageController = PageController(viewportFraction: .6);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      drawer: const NavigationDrawer(),
      endDrawer: const BuildShoppingCart(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.dehaze_rounded),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text(
          "Large",
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Locations"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Menu"),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.width * .3,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                            color: Theme.of(context).focusColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        // TEXTFIELD
                        child: const TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              isDense: true,
                              hintText: "Search...",
                              icon: Icon(
                                Icons.search,
                                size: 24,
                              )),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
        //expandedHeight: 200,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Text(
                      "Promotion",
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .fontSize),
                    ),
                    const Divider(
                      thickness: 2,
                      endIndent: 50,
                    ),
                    buildPromotionMenu(context, pageController),
                    Text(
                      "Menu",
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .fontSize),
                    ),
                    const Divider(
                      thickness: 2,
                      endIndent: 50,
                    ),
                    buildMenuCard(context, "Lunch"),
                    buildMenuCard(context, "Breakfast"),
                    buildMenuCard(context, "Snacks"),
                    buildMenuCard(context, "Drinks"),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(
            thickness: 1,
          ),
          // SIDE MENU SHOPPING CART

          SizedBox(
            width: 350,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text("Shopping Cart is Empty")),
                          ),
                        ],
                      ))
                    : Expanded(
                        child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
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
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize),
                        )),
                const Divider(
                  color: Colors.white70,
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width * .9,
                  child: buildCheckoutButton(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
