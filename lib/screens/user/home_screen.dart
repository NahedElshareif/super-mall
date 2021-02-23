




import 'package:supermall/constants.dart';
import 'package:supermall/models/product.dart';
import 'package:supermall/screens/login_screen.dart';
import 'package:supermall/screens/user/cart_screen.dart';
import 'package:supermall/screens/user/product_info.dart';
import 'package:supermall/widgets/productview.dart';
import 'package:supermall/services/store.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:supermall/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../functions.dart';

//import '../../functions.dart';

class HomeScreen extends StatefulWidget {
  static String id='HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = Auth();
  FirebaseUser _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<Product> _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: KUnActiveColor,
              currentIndex: _bottomBarIndex,
              fixedColor: KMainColor,
              onTap: (value) async {
                if (value == 1) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  await _auth.signOut();
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                }
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [
                
                BottomNavigationBarItem(
                    title: Text('Search'), icon: Icon(Icons.search)),
                BottomNavigationBarItem(
                    title: Text('Sign Out'), icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: KMainColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'Fruts',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Veg',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Dairy',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Meet',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                FrutsView(),
                ProductsView(KVeg, _products),
                ProductsView(KDairy, _products),
                ProductsView(KMeet, _products),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    getCurrenUser();
  }

  getCurrenUser() async {
    _loggedUser = await _auth.getUser();
  }

  Widget FrutsView() {
    return StreamBuilder<QuerySnapshot>(
      stream:  _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;
            products.add(Product(
                pId: doc.documentID,
                pPrice: data[KProductPrice],
                pName: data[KProductName],
                pDescription: data[KProductDescription],
                pLocation: data[KProductLocation],
                pCategory: data[KProductCategory]));
          }
          _products = [...products];
          products.clear();
          products = getProductByCategory(KFruts, _products);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductInfo.id,
                      arguments: products[index]);
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(products[index].pLocation),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  products[index].pName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('\$ ${products[index].pPrice}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            itemCount: products.length,
          );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}