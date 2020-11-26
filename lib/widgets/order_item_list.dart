import 'package:flutter/material.dart';
import 'dart:math';

import '../providers/orders.dart';
import 'package:intl/intl.dart';

class OrderItemList extends StatefulWidget {
  final OrderItem orderData;
  OrderItemList(this.orderData);

  @override
  _OrderItemListState createState() => _OrderItemListState();
}

class _OrderItemListState extends State<OrderItemList> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.orderData.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.orderData.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
            if (_expanded)
            Container(
              height: min(widget.orderData.products.length * 20.0 + 100.0, 180),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: widget.orderData.products.map(
                  (pro) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(pro.title,style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text('${pro.qunatity}x \$${pro.price}',
                        style: TextStyle(fontSize: 18,color:Colors.grey,),),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ),
        
        ],
      ),
    );
  }
}
