import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/db_services/ecommerce_services.dart';
import '../../constants.dart';
import '../../constants/app_colors.dart';
import '../../models/cart_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/dismissible_provider.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';
import 'components/custom_text.dart';
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
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(

                  "Your Cart",
                  style: TextStyle(color: Colors.black),
                ),
                InkWell(
                    onTap: (){
                   EcommerceServices.deleteAllCartItems();
                    },
                    child: const Icon(Icons.delete_rounded,color: AppColors.black,))
              ],
            ),


          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:StreamBuilder<List<CartModel>>(
          stream: cartmodel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              if (data.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }
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
                    child: CartCard(
                      cart: data[index],
                      docId: data[index].docId!,
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No Data'));
            }
          },
        ),

      ),
        bottomNavigationBar: CheckoutCard());
  }
}

class CartCard extends StatelessWidget {
  final CartModel cart;
  final String docId;

  const CartCard({super.key, required this.cart,required this.docId});

  @override
  Widget build(BuildContext context) {
    return  Container
      (
      height: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:  const Color(0xFFF5F6F9),

        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(children: [
        Expanded(
            flex: 4
            ,child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
                height: 150,
                child: Image.network(cart.imageUrl!,fit: BoxFit.cover,)))),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
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
          ),
        ),

        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
             InkWell(
               onTap: (){
                 EcommerceServices.updateQuantity(docId: docId, increment: false);
          },
               child: Container
                 (
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:  AppColors.black,

                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.remove,color: AppColors.white,),
                ),
               ),
             ),
            const Gap(10),
            CustomText(title: "${cart.quantity}",
              color: AppColors.black,
              weight: FontWeight.w600,

            ),
             const Gap(10),
              InkWell(
                onTap: (){
                  EcommerceServices.updateQuantity(docId: docId, increment: true);
                },
                child: Container
                  (
                 // height: 30,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:   AppColors.black,

                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(0),
                    child: Icon(Icons.add,color: AppColors.white,),
                  ),
                ),
              ),
            ],),
          ),
        )
      ],),
    );
  }
}
