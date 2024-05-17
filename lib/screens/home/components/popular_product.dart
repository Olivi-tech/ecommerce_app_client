import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/db_services/ecommerce_services.dart';
import 'package:shop_app/models/ecommerce_product_model.dart';

import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

late Stream<List<EcommerceProductModel>> fetchProduct;

class _PopularProductsState extends State<PopularProducts> {
  @override
  void initState() {
    fetchProduct = EcommerceServices.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        StreamBuilder<List<EcommerceProductModel>>(
            stream: fetchProduct,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoActivityIndicator();
              } else {
                final product = snapshot.data;
                final firstThreeProducts = product!.take(3).toList();
                return SizedBox(
                  height: height * 0.4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: firstThreeProducts!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ProductCard(
                          imageUrl: firstThreeProducts[index].imageUrl!,
                          price: firstThreeProducts[index].price!,
                          text: firstThreeProducts[index].title!,
                          press: () {},
                        ),
                      );
                    },
                  ),
                );
              }
            }),
        const SizedBox(width: 20)
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard(
      {this.width = 14,
      this.aspectRatio = 1.02,
      required this.imageUrl,
      required this.press,
      required this.price,
      required this.text,
      super.key});
  final String imageUrl, text;
  final num price;
  final GestureTapCallback press;
  final double width, aspectRatio;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return SizedBox(
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: height * 0.51,
          width: width * 0.5,
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: height * 0.25,
                width: width,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                '\$${price.toString()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: SizedBox(
                width: width * 0.6,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'In Stock',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.add_shopping_cart_rounded,
                      color: AppColors.black,
                    )
                  ],
                ),
              ),
            ),
            // InkWell(
            //     borderRadius: BorderRadius.circular(50),
            //     onTap: () {},
            //     child: Container(
            //         padding: const EdgeInsets.all(6),
            //         height: 24,
            //         width: 24,
            //         child: SvgPicture.asset(
            //           "assets/icons/Heart Icon_2.svg",
            //         ))),
          ]),

          // decoration: BoxDecoration(
          //   color: product.isFavourite
          //       ? kPrimaryColor.withOpacity(0.15)
          //       : kSecondaryColor.withOpacity(0.1),
          //   shape: BoxShape.circle,
          // ),
          // child: SvgPicture.asset(
          //   "assets/icons/Heart Icon_2.svg",
          // colorFilter: ColorFilter.mode(
          //     product.isFavourite
          //         ? const Color(0xFFFF4848)
          //         : const Color(0xFFDBDEE4),
          //     BlendMode.srcIn),
        ),
      ),
    );
  }
}

// class ProductCard extends StatelessWidget {
//   const ProductCard({
//     Key? key,
//     this.width = 140,
//     this.aspectRatio = 1.02,
//     required this.product,
//     required this.onPress,
//   }) : super(key: key);
//   final double width, aspectRatio;
//   final Product product;
//   final VoidCallback onPress;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       child: GestureDetector(
//         onTap: onPress,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AspectRatio(
//               aspectRatio: 1.02,
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: kSecondaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Image.network(product.images[0]),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               product.title,
//               style: Theme.of(context).textTheme.bodyMedium,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "\$${product.price}",
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: kPrimaryColor,
//                   ),
//                 ),
//                 InkWell(
//                   borderRadius: BorderRadius.circular(50),
//                   onTap: () {},
//                   child: Container(
//                     padding: const EdgeInsets.all(6),
//                     height: 24,
//                     width: 24,
//                     decoration: BoxDecoration(
//                       color: product.isFavourite
//                           ? kPrimaryColor.withOpacity(0.15)
//                           : kSecondaryColor.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: SvgPicture.asset(
//                       "assets/icons/Heart Icon_2.svg",
//                       colorFilter: ColorFilter.mode(
//                           product.isFavourite
//                               ? const Color(0xFFFF4848)
//                               : const Color(0xFFDBDEE4),
//                           BlendMode.srcIn),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
