import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3298),
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
                height: 60,
                child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    log('....................season${data!.length}');
                    log('.............saeasonName.....${data[index].season}');
                    return Text.rich(
                      TextSpan(
                        style: const TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text: "A ${data![index].season} Surpise\n"),
                          TextSpan(
                            text: "Cashback ${data[index].off}",
                            style: const TextStyle(
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
