import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supermall/constants.dart';
import 'package:supermall/models/product.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  
 
 
 
 
 
  addProduct(Product product) {
    _firestore.collection(KProductsCollection).add({
      KProductName: product.pName,
      KProductPrice: product.pPrice,
      KProductDescription: product.pDescription,
      KProductCategory: product.pCategory,
      KProductLocation: product.pLocation,
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(KProductsCollection).snapshots();
  }


  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(KOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(KOrders)
        .document(documentId)
        .collection(KOrderDetails)
        .snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(KProductsCollection).document(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore
        .collection(KProductsCollection)
        .document(documentId)
        .updateData(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(KOrders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(KOrderDetails).document().setData({
        KProductName: product.pName,
        KProductPrice: product.pPrice,
        KProductQuantity: product.pQuantity,
        KProductLocation: product.pLocation,
        KProductCategory: product.pCategory
      });
    }
  }
}

