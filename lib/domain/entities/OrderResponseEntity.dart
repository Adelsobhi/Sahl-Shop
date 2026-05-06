
class OrderResponseEntity {
  OrderResponseEntity({
      this.status, 
      this.message, 
      this.user, 
      this.pricing, 
      this.data,});

  String? status;
  String? message;
  OrderUserEntity? user;
  OrderPricingEntity? pricing;
  OrderDataEntity? data;


}



class OrderDataEntity {
  OrderDataEntity({
      this.shippingAddress, 
      this.taxPrice, 
      this.shippingPrice, 
      this.totalOrderPrice, 
      this.paymentMethodType, 
      this.isPaid, 
      this.isDelivered, 
      this.id, 
      this.user, 
      this.cartItems, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  OrderShippingAddressEntity? shippingAddress;
  num? taxPrice;
  num? shippingPrice;
  num? totalOrderPrice;
  String? paymentMethodType;
  bool? isPaid;
  bool? isDelivered;
  String? id;
  OrderUserEntity? user;
  List<OrderCartItemsEntity>? cartItems;
  String? createdAt;
  String? updatedAt;
  num? v;


}


class OrderCartItemsEntity {
  OrderCartItemsEntity({
      this.count, 
      this.id, 
      this.product, 
      this.price,});

  num? count;
  String? id;
  OrderProductEntity? product;
  num? price;


}


class OrderProductEntity {
  OrderProductEntity({
      this.subcategory, 
      this.ratingsQuantity, 
      this.id, 
      this.title, 
      this.imageCover, 
      this.category, 
      this.brand, 
      this.ratingsAverage, 
      });

  List<OrderSubcategoryEntity>? subcategory;
  num? ratingsQuantity;
  String? id;
  String? title;
  String? imageCover;
  OrderCategoryEntity? category;
  OrderBrandEntity? brand;
  num? ratingsAverage;


}



class OrderBrandEntity {
  OrderBrandEntity({
      this.id, 
      this.name, 
      this.slug, 
      this.image,});

  String? id;
  String? name;
  String? slug;
  String? image;


}



class OrderCategoryEntity {
  OrderCategoryEntity({
      this.id, 
      this.name, 
      this.slug, 
      this.image,});

  String? id;
  String? name;
  String? slug;
  String? image;


}



class OrderSubcategoryEntity {
  OrderSubcategoryEntity({
      this.id, 
      this.name, 
      this.slug, 
      this.category,});

  String? id;
  String? name;
  String? slug;
  String? category;


}


class OrderUserEntity {
  OrderUserEntity({
      this.id, 
      this.name, 
      this.email, 
      this.phone,});

  String? id;
  String? name;
  String? email;
  String? phone;


}


class OrderShippingAddressEntity {
  OrderShippingAddressEntity({
      this.details, 
      this.phone, 
      this.city, 
      this.postalCode,});

  String? details;
  String? phone;
  String? city;
  String? postalCode;


}



class OrderPricingEntity {
  OrderPricingEntity({
      this.cartPrice, 
      this.taxPrice, 
      this.shippingPrice, 
      this.totalOrderPrice,});

  OrderPricingEntity.fromJson(dynamic json) {
    cartPrice = json['cartPrice'];
    taxPrice = json['taxPrice'];
    shippingPrice = json['shippingPrice'];
    totalOrderPrice = json['totalOrderPrice'];
  }
  num? cartPrice;
  num? taxPrice;
  num? shippingPrice;
  num? totalOrderPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cartPrice'] = cartPrice;
    map['taxPrice'] = taxPrice;
    map['shippingPrice'] = shippingPrice;
    map['totalOrderPrice'] = totalOrderPrice;
    return map;
  }

}


