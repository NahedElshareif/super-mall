import 'package:supermall/constants.dart';
import 'package:supermall/models/product.dart';
import 'package:supermall/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KMainColor,
        title: Text('Order Details',
        style: TextStyle(color: 
        Colors.white,fontSize: 20,fontWeight: 
        FontWeight.bold),),
        ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadOrderDetails(documentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.documents) {
                products.add(Product(
                  pName: doc.data[KProductName],
                  pQuantity: doc.data[KProductQuantity],
                  pCategory: doc.data[KProductCategory],
                ));
              }

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          color: KSecondColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('product name : ${products[index].pName}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quantity : ${products[index].pQuantity}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'product Category : ${products[index].pCategory}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: KMainColor,
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text('Confirm Order'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: KMainColor,
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text('Delete Order'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('Loading Order Details'),
              );
            }
          }),
    );
  }
}