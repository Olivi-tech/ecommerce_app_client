import 'dart:developer';
import 'package:flutter/cupertino.dart';
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
          // Check if snapshot has data
          final List<EcommerceProductModel>? categories = snapshot.data;

          if (categories != null && categories.isNotEmpty) {
            // Check if categories is not null and not empty
            return SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    log('the image url is ${categories[index].imageUrl!}');
                    log('the category name is ${categories[index].category}');
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CategoryCard(
                        imageUrl: categories[index].imageUrl!,
                        text: categories[index].category!,
                        press: () {},
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Text('No data available'); // Handle empty data case
          }
        } else {
          return const Text('no data available');
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
              padding: const EdgeInsets.all(16),
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              )),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
