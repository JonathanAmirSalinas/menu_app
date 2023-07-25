import 'package:flutter/material.dart';
import 'package:menu_app/model/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          //Focus.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Checkout"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer Information",
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          buildCheckoutTextField(
                              "First Name", firstNameController, 'text'),
                          buildCheckoutTextField(
                              "Last Name", lastNameController, 'text'),
                          buildCheckoutTextField(
                              "Email Name", emailController, 'email'),
                          buildCheckoutTextField(
                              "Phone Number", phoneNumberController, 'number'),
                        ],
                      ),
                    ),
                    buildCheckoutReviewOrder(),
                    buildCompleteOrderButton(),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Textfield Widget
  buildCheckoutTextField(
      String label, TextEditingController controller, String keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$label*',
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .8,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            // TEXTFORMFIELD
            child: TextFormField(
                controller: controller,
                keyboardType: keyboardType == 'text'
                    ? TextInputType.name
                    : keyboardType == 'email'
                        ? TextInputType.emailAddress
                        : TextInputType.phone,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: label,
                ))),
      ],
    );
  }

  // Listview builder of item/items in User's cart
  buildCheckoutReviewOrder() {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review Order",
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
        ),
        cartProvider.cart.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .54,
                  width: MediaQuery.of(context).size.width * .8,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: cartProvider.cart.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCheckoutItems(index);
                    },
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width * .5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Theme.of(context).cardColor),
                  child: Text(
                    "Cart Is Empty",
                    style: TextStyle(
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .fontSize),
                  ),
                ),
              ),
        Text(
          "Order Recipt",
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .8,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Subtotal: ${cartProvider.total.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize),
              ),
              Text(
                "Tax: ${(cartProvider.total * .0825).toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize),
              ),
              Text(
                "Total: ${(cartProvider.total + (cartProvider.total * .0825)).toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildCheckoutItems(int index) {
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                            image: AssetImage(
                                cartProvider.cart[index].productImage),
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

  buildCompleteOrderButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.receipt),
          label: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * .05,
            width: 300,
            child: Text(
              "Complete Order",
              style: TextStyle(
                  fontSize:
                      Theme.of(context).textTheme.headlineSmall!.fontSize),
            ),
          )),
    );
  }
}
