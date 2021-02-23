import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supermall/constants.dart';
import 'package:supermall/models/product.dart';
import 'package:supermall/screens/admin/addproduct.dart';
import 'package:supermall/screens/admin/manageproduct.dart';
import 'package:supermall/screens/admin/orderscreen.dart';
import 'package:supermall/services/store.dart';
import 'package:supermall/widgets/custom_textField.dart';
import 'dart:io';

class AdminScreen extends StatefulWidget {
  static String id = 'AdminScreen';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KMainColor,
        centerTitle: true,
        title: Text(
              'Admin Dashbord',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )), 
        
      //backgroundColor: KMainColor,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
          SizedBox(
            height: 100,
            width: double.infinity,
          ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: KMainColor,
            onPressed: () {
              takeImage(context);
              //Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text(
              'Add  Product',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text(
              'Edit Product',
              style: TextStyle(color: KMainColor, fontSize: 25),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: KMainColor,
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text(
              'View orders',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          )
        ],
      ),
    );
  }

  takeImage(_context) {
    return showDialog(
        context: _context,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              'ItemImage',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  'Capture with Camera',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: ()async {
                
                await  capturePhotoWithCamera();
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return AddProduct(_image);
                }));
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'Select from Galary',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.pop(_context);
                  pickPhotoFromGalary();
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.pop(_context);
                },
              )
            ],
          );
        });
  }


Future capturePhotoWithCamera() async {
final pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
setState(() {
  if (pickedImage != null) {
    _image = File(pickedImage.path);

    
    print('_image: $_image');
  } else {
    print('No image selected');
  }
});
  }
 
  
  Future pickPhotoFromGalary() async {
final pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
setState(() {
  if (pickedImage != null) {
      _image = File(pickedImage.path);

    
    print('_image: $_image');
  } else {
    print('No image selected');
  }
});
  }
  

displyAdminUploadFormScreen(){
  return Scaffold(  
      
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Product',style: TextStyle(color: Colors.white,fontSize: 25),),
        backgroundColor: KMainColor,),
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

             decoration: BoxDecoration( image: DecorationImage(image: FileImage(_image),), ),
            ),
            
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            Divider(color: KMainColor,),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _price = value;
              },
              hint: 'Product Price',
            ),
            Divider(color: KMainColor,),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _description = value;
              },
              hint: 'Product Description',
            ),
            Divider(color: KMainColor,),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _category = value;
              },
              hint: 'Product Category',
            ),
            Divider(color: KMainColor,),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _imageLocation = value;
              },
              hint: 'Product Location',
            ),
            Divider(color: KMainColor,),
            SizedBox(
              height: 20,
            ),
            Divider(color: KMainColor,),    
           SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: KMainColor,
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();

                  _store.addProduct(Product(
                      pName: _name,
                      pPrice: _price,
                      pDescription: _description,
                      pLocation: _imageLocation,
                      pCategory: _category));
                }
              },
              child: Text('Add Product',style: TextStyle(fontSize: 20,color: Colors.white),),
            )
          ],
        ),
      ),
    );
}



}
