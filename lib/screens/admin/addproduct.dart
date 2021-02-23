

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supermall/constants.dart';
import 'package:supermall/widgets/custom_textField.dart';
import 'package:supermall/services/store.dart';
import 'package:supermall/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';




class AddProduct extends StatelessWidget {
  File file;
  
  AddProduct(this.file);
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _imageLocation,pId;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Product',style: TextStyle(color: Colors.white,fontSize: 25),),
        backgroundColor: KMainColor,),
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: ListView(
         
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
             height: 150,
             width: MediaQuery.of(context).size.width * 0.7,
             child: Center(
               child:Container(
                 decoration: BoxDecoration( image: DecorationImage(image: FileImage(file),fit: BoxFit.cover), ),
               ),
             ),
             
            ),
             
            
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
           
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _price = value;
              },
              hint: 'Product Price',
            ),
            
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _description = value;
              },
              hint: 'Product Description',
            ),
           
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _category = value;
              },
              hint: 'Product Category',
            ),
            
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _imageLocation = value;
              },
              hint: 'Product Location',
            ),
            
            SizedBox(
              height: 20,
            ),
            
            RaisedButton(
              color: KMainColor,
              onPressed: ()  async {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  

                  _store.addProduct(Product(
                      pName: _name,
                      pPrice: _price,
                      pDescription: _description,
                      pLocation:  await uploadProductImage(file) ,
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

Future<String> uploadProductImage(image) async{

   final StorageReference storageRefernce= FirebaseStorage.instance.ref().child('Products');

   StorageUploadTask uploadTask= storageRefernce.child("p_$pId.jpg").putFile(image);
   StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
   String downloadUrl= await  taskSnapshot.ref.getDownloadURL();
   return downloadUrl;

}






}



