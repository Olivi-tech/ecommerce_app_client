import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/db_services/ecommerce_services.dart';

import 'package:shop_app/models/deals_model.dart';
import 'package:shop_app/screens/cart/components/custom_text.dart';

import '../../Widgets/custom_appbar.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});
  static String routeName = "/products";

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

late Stream<List<DealModel>> fetchDeals;
TextEditingController controller = TextEditingController();
ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
List<DealModel> filteredData = [];
List<DealModel> dealdata = [];

class _DealsScreenState extends State<DealsScreen> {
  @override
  void initState() {
    fetchDeals = EcommerceServices.fetchDeal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder<List<DealModel>>(
              stream: fetchDeals,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator();
                } else {
                  final deals = snapshot.data;
                  return ValueListenableBuilder(
                    valueListenable: searchNotifier,
                    builder: (context, value, child) {
                      List<DealModel> displayedDeals = value.isEmpty
                          ? snapshot.data!
                          : snapshot.data!
                              .where((deal) => deal.title!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();

                      if (displayedDeals.isNotEmpty) {
                        return GridView.builder(
                          itemCount: displayedDeals.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 280,
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) => SpecialOfferCard(
                            price: displayedDeals[index].price,
                            title: displayedDeals[index].title!,
                            image: displayedDeals[index].imageUrl!,
                            press: () {},
                          ),
                        );
                      } else {
                        return const Center(
                          child: CustomText(
                            title: 'No deals available here',
                          ),
                        );
                      }
                    },
                  );
                }
              }),
        ),
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  final String title, image;
  final num? price;
  final GestureTapCallback press;
  const SpecialOfferCard({
    Key? key,
    required this.price,
    required this.title,
    required this.image,
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
                      Icon(
                        Icons.favorite_outline_outlined,
                        size: 18,
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
