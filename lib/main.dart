import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermall/constants.dart';
import 'package:supermall/provider/adminMode.dart';
import 'package:supermall/provider/cartitem.dart';
import 'package:supermall/provider/modelhud.dart';
import 'package:supermall/screens/admin/addproduct.dart';
import 'package:supermall/screens/admin/admin_screen.dart';
import 'package:supermall/screens/admin/manageproduct.dart';
import 'package:supermall/screens/admin/orderdetails.dart';
import 'package:supermall/screens/admin/orderscreen.dart';
import 'package:supermall/screens/user/cart_screen.dart';
import 'package:supermall/screens/user/home_screen.dart';
import 'package:supermall/screens/login_screen.dart';
import 'package:supermall/screens/signup_screen.dart';
import 'package:supermall/screens/user/product_info.dart';




main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Loading....'),
              ),
            ),
          );
        }

     else{
       isUserLoggedIn = snapshot.data.getBool(KKeepMeLoggedIn) ?? false;
       return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context)=>ModelHud(),),
        ChangeNotifierProvider<AdminMode>(
          create: (context)=>AdminMode(),),
        ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),

      ],
          child: MaterialApp(
          initialRoute: isUserLoggedIn ? HomeScreen.id : LoginScreen.id,
          routes: {
            LoginScreen.id:(context)=>LoginScreen(),
            SignupScreen.id:(context)=>SignupScreen(),
            HomeScreen.id:(context)=>HomeScreen(),
            AdminScreen.id:(context)=>AdminScreen(),
            ManageProducts.id:(context)=>ManageProducts(),
            //EditProduct.id: (context) => EditProduct(),
            OrderDetails.id:(context)=>OrderDetails(),
            OrdersScreen.id:(context)=>OrdersScreen(),
            CartScreen.id: (context) => CartScreen(),
            ProductInfo.id: (context) => ProductInfo(),
                

          },//routs mab
        ),
    );
    }
     


      },
      );
    
    

  }
}
