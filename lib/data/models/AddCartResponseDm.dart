import 'package:sahl_shop/domain/entities/AddCartResponseEntity.dart';

/// status : "success"
/// message : "Product added successfully to your cart"
/// numOfCartItems : 1
/// cartId : "69eba6b72b77870012aa69ed"
/// data : {"_id":"69eba6b72b77870012aa69ed","cartOwner":"69decf66cff7dd67a8224bd1","products":[{"count":1,"_id":"69eba6b72b77870012aa69ee","product":"6428eb43dc1175abc65ca0b3","price":149}],"createdAt":"2026-04-24T17:21:59.207Z","updatedAt":"2026-04-24T17:21:59.240Z","__v":0,"totalCartPrice":149}

class AddCartResponseDm extends AddCartResponseEntity{
  AddCartResponseDm({
      super.status,
    super.message,
    super.numOfCartItems,
    super.cartId,
    super.data,
    this.statusMsg
  });

  AddCartResponseDm.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    statusMsg = json['statusMsg'];
    numOfCartItems = json['numOfCartItems'];
    cartId = json['cartId'];
    data = json['data'] != null ? AddDataDm.fromJson(json['data']) : null;
  }
 String? statusMsg;


}

/// _id : "69eba6b72b77870012aa69ed"
/// cartOwner : "69decf66cff7dd67a8224bd1"
/// products : [{"count":1,"_id":"69eba6b72b77870012aa69ee","product":"6428eb43dc1175abc65ca0b3","price":149}]
/// createdAt : "2026-04-24T17:21:59.207Z"
/// updatedAt : "2026-04-24T17:21:59.240Z"
/// __v : 0
/// totalCartPrice : 149

class AddDataDm extends AddDataEntity {
  AddDataDm({
      super.id,
    super.cartOwner,
    super.products,
    super.createdAt,
    super.updatedAt,
    super.v,
    super.totalCartPrice,});

  AddDataDm.fromJson(dynamic json) {
    id = json['_id'];
    cartOwner = json['cartOwner'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(AddProductsDm.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }


}

/// count : 1
/// _id : "69eba6b72b77870012aa69ee"
/// product : "6428eb43dc1175abc65ca0b3"
/// price : 149

class AddProductsDm  extends AddProductsEntity{
  AddProductsDm({
      super.count,
    super.id,
    super.product,
    super.price,});

  AddProductsDm.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    product = json['product'];
    price = json['price'];
  }


}