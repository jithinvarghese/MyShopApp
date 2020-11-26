import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_item_list.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const screenName = '/order-screen';
  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderList.orders.length,
        itemBuilder:(context,index) => OrderItemList(orderList.orders[index]),
      ),
      
    );
  }
}