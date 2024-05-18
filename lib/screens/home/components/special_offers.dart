import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/db_services/ecommerce_services.dart';
import 'package:shop_app/models/deals_model.dart';
import 'package:shop_app/screens/cart/components/custom_text.dart';
import 'package:shop_app/screens/products/deals_products_screen.dart';
import '../../../providers/favourite_provider.dart';
import '../../products/see_more_deals.dart';
import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

late Stream<List<DealModel>> fetchDeals;

class _SpecialOffersState extends State<SpecialOffers> {
  Set<String> displayedCategories = {};

  @override
  void initState() {
    fetchDeals = EcommerceServices.fetchDeal();
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Special for you",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DealsScreen(),
                  ));
            },
          ),
        ),
        StreamBuilder<List<DealModel>>(
          stream: fetchDeals,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator();
            } else {
              final deals = snapshot.data;
              Set<String> displayedCategories = Set();
              return SizedBox(
                height: height * 0.39,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: deals!.length,
                  itemBuilder: (context, index) {
                    String category = deals[index].category!;
                    if (!displayedCategories.contains(category)) {
                      displayedCategories.add(category);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SpecialOfferCard(
                          image: deals[index].imageUrl!,
                          title: deals[index].title!,
                          price: deals[index].price,
                          category: category,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DealsPRoductScreen(category: category),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatefulWidget {
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
  State<SpecialOfferCard> createState() => _SpecialOfferCardState();
}

bool isFavorite = false;

class _SpecialOfferCardState extends State<SpecialOfferCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return GestureDetector(
      onTap: widget.press,
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
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  '\$${widget.price}',
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
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.add_shopping_cart_rounded,
                          color: AppColors.black,
                        ),
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
