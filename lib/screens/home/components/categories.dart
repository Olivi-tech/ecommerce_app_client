import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/db_services/ecommerce_services.dart';
import 'package:shop_app/models/ecommerce_product_model.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Stream<List<EcommerceProductModel>> fetchProduct;
  @override
  void initState() {
    fetchProduct = EcommerceServices.fetchProducts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchProduct,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        } else if (snapshot.hasData) {
          final List<EcommerceProductModel>? products = snapshot.data;

          if (products != null && products.isNotEmpty) {
            final Set<String> uniqueCategories = {};
            final List<EcommerceProductModel> uniqueProducts = [];

            for (var product in products) {
              if (uniqueCategories.add(product.category!)) {
                uniqueProducts.add(product);
              }
            }

            if (uniqueProducts.isNotEmpty) {
              return SizedBox(
                height: 90,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: uniqueProducts.length,
                    itemBuilder: (context, index) {
                      log('the image url is ${uniqueProducts[index].imageUrl!}');
                      log('the category name is ${uniqueProducts[index].category}');
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: CategoryCard(
                          imageUrl: uniqueProducts[index].imageUrl!,
                          text: uniqueProducts[index].category!,
                          press: () {},
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return const Text('No data available');
            }
          } else {
            return const Text('No data available');
          }
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.imageUrl,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String imageUrl, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(13),
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              )),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.black),
          )
        ],
      ),
    );
  }
}
