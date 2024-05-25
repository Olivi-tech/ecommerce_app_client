import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/db_services/ecommerce_services.dart';
import '../../constants.dart';
import '../../constants/app_colors.dart';
import '../../models/cart_model.dart';
import '../../providers/dismissible_provider.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';
class CartScreen extends StatefulWidget {
  static String routeName = "/cart";
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}
late Stream<List<CartModel>> cartmodel;
late DismissibleProvider dismissibleProvider;
int totalLength = 0;
class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    dismissibleProvider = Provider.of<DismissibleProvider>(context, listen: false);
    cartmodel = EcommerceServices.fetchCartItem();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${totalLength} items",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder<List<CartModel>>(
          stream: cartmodel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              totalLength = data.length!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(data[index].docId.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      dismissibleProvider.removeCartItem(data[index].docId!);
                    },
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(cart: data[index]),
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No Data'));
            }
          },
        ),
      ),
      bottomNavigationBar: const CheckoutCard(),
    );
  }
}

class CartCard extends StatelessWidget {
  final CartModel cart;

  const CartCard({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return  Container
      (
      height: 150,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:  Color(0xFFF5F6F9),

        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(children: [
        Expanded(
            flex: 5
            ,child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(cart.imageUrl!,fit: BoxFit.cover,))),
        Expanded(
          flex: 5,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center
          ,children: [
            Text(
              cart.title!,
              style: const TextStyle(color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis),
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "\$${cart.price}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${cart.quantity}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge),
                ],
              ),
            )
          ],),
        )
      ],),
    );
  }
}
