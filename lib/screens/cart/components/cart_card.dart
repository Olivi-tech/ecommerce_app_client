// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shop_app/constants/app_colors.dart';
// import 'package:shop_app/db_services/ecommerce_services.dart';
//
// import '../../../constants.dart';
// import '../../../models/cart_model.dart';
//
//
// class CartCard extends StatefulWidget {
//   const CartCard({
//     Key? key,
//
//   }) : super(key: key);
//
//   @override
//   State<CartCard> createState() => _CartCardState();
// }
// late Stream<List<CartModel>> cartmodel;
//
// class _CartCardState extends State<CartCard> {
//   @override
//   void initState() {
//     cartmodel = EcommerceServices.fetchCartItem();
//     super.initState();
//   }
//   @override
//
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 88,
//           child: AspectRatio(
//             aspectRatio: 0.88,
//             child: StreamBuilder<List<CartModel>>(
//               stream: cartmodel,
//               builder: (context, snapshot) {
//                 if(snapshot.connectionState == ConnectionState.waiting){
//                   return const CupertinoActivityIndicator();
//                 }else{
//                   final data = snapshot.data!;
//                   log('.........data${snapshot.data}');
//                   return SizedBox(
//                     height: 100,
//                     child: ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       itemCount: data.length,
//                       itemBuilder: (context, index) => Container(
//                         padding:  EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                          // color:  Color(0xFFF5F6F9),
//                           color: AppColors.black,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       child: Row(children: [
//                         Image.network(data[index].)
//                       ],),
//                       ),
//                     ),
//                   );
//
//                 Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                 // Text(
//                 //   cart.product.title,
//                 //   style: const TextStyle(color: Colors.black, fontSize: 14,overflow: TextOverflow.ellipsis),
//                 //   maxLines: 1,
//                 // ),
//                 const SizedBox(height: 8),
//                 // Text.rich(
//                 //   TextSpan(
//                 //     text: "\$${cart.product.price}",
//                 //     style: const TextStyle(
//                 //         fontWeight: FontWeight.w600, color: kPrimaryColor),
//                 //     children: [
//                 //       TextSpan(
//                 //           text: " x${cart.numOfItem}",
//                 //           style: Theme.of(context).textTheme.bodyLarge),
//                 //     ],
//                 //   ),
//                 // )
//                 ],
//                 );
//                 }
//
//               }
//             ),
//           ),
//         ),
//
//       ],
//     );
//   }
// }
