import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart/components/address.dart';
import '../../../constants/app_colors.dart';

class CartCard extends StatefulWidget {
  const CartCard({super.key});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          titleSpacing: 0, // Remove title spacing
          title: const Text(
            'Checkout',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          bottom:  PreferredSize(
            preferredSize: Size.fromHeight(35.0),
            child: TabBar(
              controller: _tabController,
             dividerColor:AppColors.black ,
              indicatorPadding: EdgeInsets.symmetric(horizontal: -25.0),
              indicatorColor: AppColors.red,
              labelColor: AppColors.red,
              unselectedLabelColor: AppColors.black,
              labelPadding: EdgeInsets.only(bottom: 15.0),

              tabs: [
                Text('ADDRESS', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                Text('PAYMENT', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                Text('SUMMARY', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
              ],
            ),
          ),
        ),
        body:   TabBarView(
          children: [
           AddressScreen(controller: _tabController,),
            Text('Payment Content', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
            Text('Summary Content', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
