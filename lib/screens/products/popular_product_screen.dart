import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/db_services/ecommerce_services.dart';

import 'package:shop_app/models/deals_model.dart';
import 'package:shop_app/models/ecommerce_product_model.dart';
import 'package:shop_app/screens/cart/components/custom_text.dart';

import '../../Widgets/custom_appbar.dart';

class PopularProductsScreen extends StatefulWidget {
  final String category;

  const PopularProductsScreen({super.key, required this.category});
  static String routeName = "/products";

  @override
  State<PopularProductsScreen> createState() => _PopularProductsScreenState();
}

class _PopularProductsScreenState extends State<PopularProductsScreen> {
  late Stream<List<EcommerceProductModel>> fetchProducts;
  TextEditingController controller = TextEditingController();
  ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
  List<DealModel> filteredData = [];
  List<DealModel> dealdata = [];

  @override
  void initState() {
    fetchProducts = EcommerceServices.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomAppBar(
                text: 'Search via name',
                controller: controller,
                setSearchValue: (searchQuery) {
                  searchNotifier.value = searchQuery;
                  filteredData = dealdata
                      .where((data) => data.title!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                      .toList();
                }),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder<List<EcommerceProductModel>>(
            stream: fetchProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoActivityIndicator();
              } else {
                final products = snapshot.data;
                final filteredProduct = widget.category.isEmpty
                    ? products!
                    : products!
                        .where((product) => product.category == widget.category)
                        .toList();
                return ValueListenableBuilder(
                  valueListenable: searchNotifier,
                  builder: (context, value, child) {
                    List<EcommerceProductModel> displayedProduct = value.isEmpty
                        ? filteredProduct
                        : filteredProduct
                            .where((deal) => deal.title!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                    return GridView.builder(
                      itemCount: displayedProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisExtent: 280,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) => SpecialOfferCard(
                        price: displayedProduct[index].price,
                        title: displayedProduct[index].title!,
                        image: displayedProduct[index].imageUrl!,
                        category: displayedProduct[index].category!,
                        press: () {},
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  final String title, image, category;
  final num? price;
  final GestureTapCallback press;

  const SpecialOfferCard({
    Key? key,
    required this.price,
    required this.title,
    required this.image,
    required this.category,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        child: Container(
          height: height * 0.5,
          width: width * 0.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: AppColors.greyColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.2,
                width: width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  '\$${price}',
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
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
            ],
          ),
        ),
      ),
    );
  }
}
