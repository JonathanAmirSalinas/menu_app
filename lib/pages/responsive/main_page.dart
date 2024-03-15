import 'package:flutter/material.dart';
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
            child: constraints.maxWidth < 720 || constraints.maxWidth == 720
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
                backgroundColor: Colors.black,
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.dehaze_rounded),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                title: Container(
                  height: 56,
                  margin: const EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                isDense: true,
                                labelText: 'Search...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
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
                backgroundColor: Colors.black,
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
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                            SizedBox(
                              height: AppBar().preferredSize.height,
                              width: MediaQuery.of(context).size.width * .3,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          labelText: 'Search...',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Divider(
                              height: 2,
                              thickness: 2,
                            ),
                          ),
                          buildAppBottomInfo()
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
        backgroundColor: Colors.black,
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
                    SizedBox(
                      height: AppBar().preferredSize.height,
                      width: MediaQuery.of(context).size.width * .3,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  labelText: 'Search...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ]),
                    ),
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
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05),
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        height: 2,
                        thickness: 2,
                      ),
                    ),
                    buildAppBottomInfo()
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
                          ' Cart Total: \$${cartProvider.total.toStringAsFixed(2)}',
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

  // Bottom Menu App Info
  buildAppBottomInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Food delivery apps are third-party delivery services hosted on mobile applications that restaurants or retailers partner with to showcase their menu and food offerings, allowing customers to order food and get it delivered to their doorstep.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Follow us at: "),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.facebook_rounded,
                    color: Colors.blueAccent,
                  ),
                ),
                Icon(
                  Icons.tiktok_rounded,
                  color: Colors.purpleAccent,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
