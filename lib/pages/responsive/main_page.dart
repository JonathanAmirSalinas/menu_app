import 'package:flutter/material.dart';
import 'package:menu_app/model/item_model.dart';
import 'package:menu_app/model/providers/cart_provider.dart';
import 'package:menu_app/model/providers/menu_provider.dart';
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
  void initState() {
    super.initState();
  }

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
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    final pageController = PageController(viewportFraction: .85);
    return Scaffold(
        drawer: const MainNavigationDrawer(),
        endDrawer: const BuildShoppingCart(),
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
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
                title: Container(
                    height: 45,
                    width: double.infinity,
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Theme.of(context).focusColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    // TEXTFIELD
                    child: const TextField(
                      decoration: InputDecoration.collapsed(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search",
                      ),
                    )),

                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      constraints: const BoxConstraints(),
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
                        buildMenuCard(
                            context,
                            "Lunch",
                            'lib/assets/lunch_menu_main.jpg',
                            menuProvider.lunchMenu),
                        buildMenuCard(
                            context,
                            "Breakfast",
                            'lib/assets/breakfast_menu_main.jpg',
                            menuProvider.breakfastMenu),
                        buildMenuCard(
                            context,
                            "Snacks",
                            'lib/assets/snacks_menu_main.jpg',
                            menuProvider.snacksMenu),
                        buildMenuCard(
                            context,
                            "Drinks",
                            'lib/assets/drinks_menu_main.jpg',
                            menuProvider.drinksMenu),
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
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    final pageController =
        PageController(keepPage: true, viewportFraction: .85);
    return Scaffold(
        drawer: const MainNavigationDrawer(),
        endDrawer: const BuildShoppingCart(),
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
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
                          buildMenuCard(
                              context,
                              "Lunch",
                              'lib/assets/lunch_menu_main.jpg',
                              menuProvider.lunchMenu),
                          buildMenuCard(
                              context,
                              "Breakfast",
                              'lib/assets/breakfast_menu_main.jpg',
                              menuProvider.breakfastMenu),
                          buildMenuCard(
                              context,
                              "Snacks",
                              'lib/assets/snacks_menu_main.jpg',
                              menuProvider.snacksMenu),
                          buildMenuCard(
                              context,
                              "Drinks",
                              'lib/assets/drinks_menu_main.jpg',
                              menuProvider.drinksMenu),
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
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    final pageController = PageController(viewportFraction: .6);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      drawer: const MainNavigationDrawer(),
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
                    buildMenuCard(
                        context,
                        "Lunch",
                        'lib/assets/lunch_menu_main.jpg',
                        menuProvider.lunchMenu),
                    buildMenuCard(
                        context,
                        "Breakfast",
                        'lib/assets/breakfast_menu_main.jpg',
                        menuProvider.breakfastMenu),
                    buildMenuCard(
                        context,
                        "Snacks",
                        'lib/assets/snacks_menu_main.jpg',
                        menuProvider.snacksMenu),
                    buildMenuCard(
                        context,
                        "Drinks",
                        'lib/assets/drinks_menu_main.jpg',
                        menuProvider.drinksMenu),
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
