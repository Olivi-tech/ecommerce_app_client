import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/db_services/ecommerce_services.dart';
import 'package:shop_app/models/off_model.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);
  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

late Stream<List<OffModel>> fetchSeasonOff;

class _DiscountBannerState extends State<DiscountBanner> {
  @override
  void initState() {
    fetchSeasonOff = EcommerceServices.fetchOff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: StreamBuilder<List<OffModel>>(
          stream: fetchSeasonOff,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator();
            } else {
              final data = snapshot.data;

              return SizedBox(
                height: 100,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    log('....................season${data!.length}');
                    log('.............saeasonName.....${data[index].season}');
                    return Text.rich(
                      TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: "A ${data![index].season} Surpise\n",
                              style: const TextStyle(color: AppColors.black)),
                          TextSpan(
                            text: "Cashback ${data[index].off}",
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
