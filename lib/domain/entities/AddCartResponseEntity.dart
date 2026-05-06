/// status : "success"
/// message : "Product added successfully to your cart"
/// numOfCartItems : 1
/// cartId : "69eba6b72b77870012aa69ed"
/// data : {"_id":"69eba6b72b77870012aa69ed","cartOwner":"69decf66cff7dd67a8224bd1","products":[{"count":1,"_id":"69eba6b72b77870012aa69ee","product":"6428eb43dc1175abc65ca0b3","price":149}],"createdAt":"2026-04-24T17:21:59.207Z","updatedAt":"2026-04-24T17:21:59.240Z","__v":0,"totalCartPrice":149}

class AddCartResponseEntity {
  AddCartResponseEntity({
      this.status, 
      this.message, 
      this.numOfCartItems, 
      this.cartId, 
      this.data,});

  String? status;
  String? message;
  num? numOfCartItems;
  String? cartId;
  AddDataEntity? data;


}

/// _id : "69eba6b72b77870012aa69ed"
/// cartOwner : "69decf66cff7dd67a8224bd1"
/// products : [{"count":1,"_id":"69eba6b72b77870012aa69ee","product":"6428eb43dc1175abc65ca0b3","price":149}]
/// createdAt : "2026-04-24T17:21:59.207Z"
/// updatedAt : "2026-04-24T17:21:59.240Z"
/// __v : 0
/// totalCartPrice : 149

class AddDataEntity {
  AddDataEntity({
      this.id, 
      this.cartOwner, 
      this.products, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.totalCartPrice,});

  String? id;
  String? cartOwner;
  List<AddProductsEntity>? products;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? totalCartPrice;


}

/// count : 1
/// _id : "69eba6b72b77870012aa69ee"
/// product : "6428eb43dc1175abc65ca0b3"
/// price : 149

class AddProductsEntity {
  AddProductsEntity({
      this.count, 
      this.id, 
      this.product, 
      this.price,});

  num? count;
  String? id;
  String? product;
  num? price;


}