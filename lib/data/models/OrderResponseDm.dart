
import 'package:sahl_shop/domain/entities/OrderResponseEntity.dart';

class OrderResponseDm extends OrderResponseEntity {
  OrderResponseDm({
    super.status,
    super.message,
    super.user,
    super.pricing,
    super.data,});

  OrderResponseDm.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? OrderUserDm.fromJson(json['user']) : null;
    pricing = json['pricing'] != null ? OrderPricingDm.fromJson(json['pricing']) : null;
    data = json['data'] != null ? OrderDataDm.fromJson(json['data']) : null;
  }


}

class OrderDataDm extends OrderDataEntity {
  OrderDataDm({
    super.shippingAddress,
    super.taxPrice,
    super.shippingPrice,
    super.totalOrderPrice,
    super.paymentMethodType,
    super.isPaid,
    super.isDelivered,
    super.id,
    super.user,
    super.cartItems,
    super.createdAt,
    super.updatedAt,
    super.v,});

  OrderDataDm.fromJson(dynamic json) {
    shippingAddress = json['shippingAddress'] != null ? OrderShippingAddressDm.fromJson(json['shippingAddress']) : null;
    taxPrice = json['taxPrice'];
    shippingPrice = json['shippingPrice'];
    totalOrderPrice = json['totalOrderPrice'];
    paymentMethodType = json['paymentMethodType'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    id = json['_id'];
    user = json['user'] != null ? OrderUserDm.fromJson(json['user']) : null;
    if (json['cartItems'] != null) {
      cartItems = [];
      json['cartItems'].forEach((v) {
        cartItems?.add(OrderCartItemsDm.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }



}


class OrderCartItemsDm extends OrderCartItemsEntity {
  OrderCartItemsDm({
    super.count,
    super.id,
    super.product,
    super.price,});

  OrderCartItemsDm.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    product = json['product'] != null ? OrderProductDm.fromJson(json['product']) : null;
    price = json['price'];
  }



}


class OrderProductDm  extends OrderProductEntity {
  OrderProductDm({
    super.subcategory,
    super.ratingsQuantity,
    super.id,
    super.title,
    super.imageCover,
    super.category,
    super.brand,
    super.ratingsAverage,
  });

  OrderProductDm.fromJson(dynamic json) {
    if (json['subcategory'] != null) {
      subcategory = [];
      json['subcategory'].forEach((v) {
        subcategory?.add(OrderSubcategoryDm.fromJson(v));
      });
    }
    ratingsQuantity = json['ratingsQuantity'];
    id = json['_id'];
    title = json['title'];
    imageCover = json['imageCover'];
    category = json['category'] != null ? OrderCategoryDM.fromJson(json['category']) : null;
    brand = json['brand'] != null ? OrderBrandDm.fromJson(json['brand']) : null;
    ratingsAverage = json['ratingsAverage'];
  }



}


class OrderBrandDm extends OrderBrandEntity {
  OrderBrandDm({
    super.id,
    super.name,
    super.slug,
    super.image,});

  OrderBrandDm.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }


}


class OrderCategoryDM extends OrderCategoryEntity {
  OrderCategoryDM({
    super.id,
    super.name,
    super.slug,
    super.image,});

  OrderCategoryDM.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }


}



class OrderSubcategoryDm extends OrderSubcategoryEntity {
  OrderSubcategoryDm({
    super.id,
    super.name,
    super.slug,
    super.category,});

  OrderSubcategoryDm.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }



}




class OrderShippingAddressDm  extends OrderShippingAddressEntity {
  OrderShippingAddressDm({
    super.details,
    super.phone,
    super.city,
    super.postalCode,});

  OrderShippingAddressDm.fromJson(dynamic json) {
    details = json['details'];
    phone = json['phone'];
    city = json['city'];
    postalCode = json['postalCode'];
  }


}


class OrderPricingDm extends OrderPricingEntity {
  OrderPricingDm({
    super.cartPrice,
    super.taxPrice,
    super.shippingPrice,
    super.totalOrderPrice,});

  OrderPricingDm.fromJson(dynamic json) {
    cartPrice = json['cartPrice'];
    taxPrice = json['taxPrice'];
    shippingPrice = json['shippingPrice'];
    totalOrderPrice = json['totalOrderPrice'];
  }


}


class OrderUserDm extends OrderUserEntity {
  OrderUserDm({
    super.id,
    super.name,
    super.email,});

  OrderUserDm.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }


}