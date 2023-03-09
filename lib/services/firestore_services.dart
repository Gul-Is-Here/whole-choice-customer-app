import 'package:whole_choice_customer/consts/consts.dart';

class FirestoreServies {
  // get users Data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where("id", isEqualTo: uid)
        .snapshots();
  }

  //  get products According to Category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getProductSubCategory(title) {
    return firestore
        .collection(productsCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }
  //  get Cart

  static getCart(uid) {
    return firestore
        .collection(cartCollectioin)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  // delete document
  static deleteDocument(docId) {
    return firestore.collection(cartCollectioin).doc(docId).delete();
  }

  // Get all Messages
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getAllWislists() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

//     Profile  Screen cart wishlist order counts
  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollectioin)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  static allProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  // Get Featured Products
  static getFeaturedProduct() {
    return firestore
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .snapshots();
  }

  static getSearchProducts(title) {
    return firestore.collection(productsCollection).get();
  }
}
