import 'package:ordersalla/models/voucher/Hrefs.dart';
import 'package:ordersalla/models/voucher/Sbsinventoryprices.dart';
import 'package:ordersalla/models/DataModel.dart';

import '../DataModel.dart';

class OrdersModel {
  var status;
  var success;
  List<DataModel2>? data;
  Pagination? pagination;

  OrdersModel({this.status, this.success, this.data, this.pagination});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <DataModel2>[];
      json['data'].forEach((v) {
        data!.add(new DataModel2.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}


class Urls {
  var customer;
  var admin;

  Urls({this.customer, this.admin});

  Urls.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer'] = this.customer;
    data['admin'] = this.admin;
    return data;
  }
}

class Date {
  String? date;
  int? timezoneType;
  String? timezone;

  Date({this.date, this.timezoneType, this.timezone});

  Date.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

class SourceDetails {
  var type;
  var value;
  var device;
  var userAgent;
  var ip;

  SourceDetails({this.type, this.value, this.device, this.userAgent, this.ip});

  SourceDetails.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    device = json['device'];
    userAgent = json['user-agent'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['device'] = this.device;
    data['user-agent'] = this.userAgent;
    data['ip'] = this.ip;
    return data;
  }
}

class Status {
  var id;
  var name;
  var slug;
  Customized? customized;

  Status({this.id, this.name, this.slug, this.customized});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    customized = json['customized'] != null
        ? new Customized.fromJson(json['customized'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    if (this.customized != null) {
      data['customized'] = this.customized!.toJson();
    }
    return data;
  }
}

class Customized {
  var id;
  var name;

  Customized({this.id, this.name});

  Customized.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Amounts {
  SubTotal? subTotal;
  ShippingCost? shippingCost;
  ShippingCost? cashOnDelivery;
  Tax? tax;
  List<Discounts>? discounts;
  SubTotal? total;

  Amounts(
      {this.subTotal,
        this.shippingCost,
        this.cashOnDelivery,
        this.tax,
        this.discounts,
        this.total});

  Amounts.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'] != null
        ? new SubTotal.fromJson(json['sub_total'])
        : null;
    shippingCost = json['shipping_cost'] != null
        ? new ShippingCost.fromJson(json['shipping_cost'])
        : null;
    cashOnDelivery = json['cash_on_delivery'] != null
        ? new ShippingCost.fromJson(json['cash_on_delivery'])
        : null;
    tax = json['tax'] != null ? new Tax.fromJson(json['tax']) : null;
    if (json['discounts'] != null) {
      discounts = <Discounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(new Discounts.fromJson(v));
      });
    }
    total = json['total'] != null ? new SubTotal.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subTotal != null) {
      data['sub_total'] = this.subTotal!.toJson();
    }
    if (this.shippingCost != null) {
      data['shipping_cost'] = this.shippingCost!.toJson();
    }
    if (this.cashOnDelivery != null) {
      data['cash_on_delivery'] = this.cashOnDelivery!.toJson();
    }
    if (this.tax != null) {
      data['tax'] = this.tax!.toJson();
    }
    if (this.discounts != null) {
      data['discounts'] = this.discounts!.map((v) => v.toJson()).toList();
    }
    if (this.total != null) {
      data['total'] = this.total!.toJson();
    }
    return data;
  }
}

class SubTotal {
  var amount;
  var currency;

  SubTotal({this.amount, this.currency});

  SubTotal.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}

class ShippingCost {
  var amount;
  var currency;

  ShippingCost({this.amount, this.currency});

  ShippingCost.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}

class Tax {
  var percent;
  SubTotal? amount;

  Tax({this.percent, this.amount});

  Tax.fromJson(Map<String, dynamic> json) {
    percent = json['percent'];
    amount =
    json['amount'] != null ? new SubTotal.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percent'] = this.percent;
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    return data;
  }
}

class Discounts {
  var title;
  var type;
  var code;
  var discount;
  var currency;
  var discountedShipping;
  var hasMarketing;

  Discounts(
      {this.title,
        this.type,
        this.code,
        this.discount,
        this.currency,
        this.discountedShipping,
        this.hasMarketing});

  Discounts.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    code = json['code'];
    discount = json['discount'];
    currency = json['currency'];
    discountedShipping = json['discounted_shipping'];
    hasMarketing = json['hasMarketing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['currency'] = this.currency;
    data['discounted_shipping'] = this.discountedShipping;
    data['hasMarketing'] = this.hasMarketing;
    return data;
  }
}

class Shipping {
  var id;
  var appId;
  var company;
  var logo;
  Receiver? receiver;
  Shipper? shipper;
  PickupAddress? pickupAddress;
  PickupAddress? address;
  Shipment? shipment;
  List<Null>? policyOptions;

  Shipping(
      {this.id,
        this.appId,
        this.company,
        this.logo,
        this.receiver,
        this.shipper,
        this.pickupAddress,
        this.address,
        this.shipment,
        this.policyOptions});

  Shipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    company = json['company'];
    logo = json['logo'];
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
    shipper =
    json['shipper'] != null ? new Shipper.fromJson(json['shipper']) : null;
    pickupAddress = json['pickup_address'] != null
        ? new PickupAddress.fromJson(json['pickup_address'])
        : null;
    address = json['address'] != null
        ? new PickupAddress.fromJson(json['address'])
        : null;
    shipment = json['shipment'] != null
        ? new Shipment.fromJson(json['shipment'])
        : null;
   /* if (json['policy_options'] != null) {
      policyOptions = <Null>[];
      json['policy_options'].forEach((v) {
        policyOptions!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['company'] = this.company;
    data['logo'] = this.logo;
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    if (this.shipper != null) {
      data['shipper'] = this.shipper!.toJson();
    }
    if (this.pickupAddress != null) {
      data['pickup_address'] = this.pickupAddress!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.shipment != null) {
      data['shipment'] = this.shipment!.toJson();
    }
   /* if (this.policyOptions != null) {
      data['policy_options'] =
          this.policyOptions!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Receiver {
  var name;
  var email;
  var phone;

  Receiver({this.name, this.email, this.phone});

  Receiver.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Shipper {
  var name;
  var companyName;
  var email;
  var phone;

  Shipper({this.name, this.companyName, this.email, this.phone});

  Shipper.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class PickupAddress {
  var country;
  var countryCode;
  var city;
  var shippingAddress;
  var streetNumber;
  var block;
  var postalCode;
  GeoCoordinates? geoCoordinates;

  PickupAddress(
      {this.country,
        this.countryCode,
        this.city,
        this.shippingAddress,
        this.streetNumber,
        this.block,
        this.postalCode,
        this.geoCoordinates});

  PickupAddress.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    countryCode = json['country_code'];
    city = json['city'];
    shippingAddress = json['shipping_address'];
    streetNumber = json['street_number'];
    block = json['block'];
    postalCode = json['postal_code'];
    geoCoordinates = json['geo_coordinates'] != null
        ? new GeoCoordinates.fromJson(json['geo_coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['city'] = this.city;
    data['shipping_address'] = this.shippingAddress;
    data['street_number'] = this.streetNumber;
    data['block'] = this.block;
    data['postal_code'] = this.postalCode;
    if (this.geoCoordinates != null) {
      data['geo_coordinates'] = this.geoCoordinates!.toJson();
    }
    return data;
  }
}

class GeoCoordinates {
  var lat;
  var lng;

  GeoCoordinates({this.lat, this.lng});

  GeoCoordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Shipment {
  var id;
  var pickupId;
  var trackingLink;
  List<String>? label;

  Shipment({this.id, this.pickupId, this.trackingLink, this.label});

  Shipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupId = json['pickup_id'];
    trackingLink = json['tracking_link'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pickup_id'] = this.pickupId;
    data['tracking_link'] = this.trackingLink;

    return data;
  }
}

class ShipmentBranch {
  var id;
  var name;
  var status;
  bool? isDefault;
  List<Null>? type;

  ShipmentBranch({this.id, this.name, this.status, this.isDefault, this.type});

  ShipmentBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    isDefault = json['is_default'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['is_default'] = this.isDefault;
    return data;
  }
}

class Customer {
  var id;
  var firstName;
  var lastName;
  var mobile;
  var mobileCode;
  var email;
  var urls;
  var avatar;
  var gender;
  var birthday;
  var city;
  var country;
  var countryCode;
  var currency;
  var location;
  Date? updatedAt;

  Customer(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobile,
        this.mobileCode,
        this.email,
        this.urls,
        this.avatar,
        this.gender,
        this.birthday,
        this.city,
        this.country,
        this.countryCode,
        this.currency,
        this.location,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    mobileCode = json['mobile_code'];
    email = json['email'];
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
    avatar = json['avatar'];
    gender = json['gender'];
    birthday =
    json['birthday'] != null ? new Date.fromJson(json['birthday']) : null;
    city = json['city'];
    country = json['country'];
    countryCode = json['country_code'];
    currency = json['currency'];
    location = json['location'];
    updatedAt = json['updated_at'] != null
        ? new Date.fromJson(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    data['mobile_code'] = this.mobileCode;
    data['email'] = this.email;
    if (this.urls != null) {
      data['urls'] = this.urls!.toJson();
    }
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    if (this.birthday != null) {
      data['birthday'] = this.birthday!.toJson();
    }
    data['city'] = this.city;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['currency'] = this.currency;
    data['location'] = this.location;
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt!.toJson();
    }
    return data;
  }
}

class Items {
  var id;
  var name;
  var sku;
  var quantity;
  var currency;
  var weight;
  var weightLabel;
  Amounts? amounts;
  var notes;
  Product? product;
  List<Options>? options;
  List<Null>? images;
  List<Null>? codes;
  List<Null>? files;

  Items(
      {this.id,
        this.name,
        this.sku,
        this.quantity,
        this.currency,
        this.weight,
        this.weightLabel,
        this.amounts,
        this.notes,
        this.product,
        this.options,
        this.images,
        this.codes,
        this.files});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    quantity = json['quantity'];
    currency = json['currency'];
    weight = json['weight'];
    weightLabel = json['weight_label'];
    amounts =
    json['amounts'] != null ? new Amounts.fromJson(json['amounts']) : null;
    notes = json['notes'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['quantity'] = this.quantity;
    data['currency'] = this.currency;
    data['weight'] = this.weight;
    data['weight_label'] = this.weightLabel;
    if (this.amounts != null) {
      data['amounts'] = this.amounts!.toJson();
    }
    data['notes'] = this.notes;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Product {
  var id;
  var type;
  Promotion? promotion;
  var status;
  bool? isAvailable;
  var sku;
  var name;
  ShippingCost? price;
  ShippingCost? salePrice;
  var currency;
  var url;
  var thumbnail;
  bool? hasSpecialPrice;
  SubTotal? regularPrice;
  Null? calories;
  Null? mpn;
  Null? gtin;
  Null? favorite;

  Product(
      {this.id,
        this.type,
        this.promotion,
        this.status,
        this.isAvailable,
        this.sku,
        this.name,
        this.price,
        this.salePrice,
        this.currency,
        this.url,
        this.thumbnail,
        this.hasSpecialPrice,
        this.regularPrice,
        this.calories,
        this.mpn,
        this.gtin,
        this.favorite});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    promotion = json['promotion'] != null
        ? new Promotion.fromJson(json['promotion'])
        : null;
    status = json['status'];
    isAvailable = json['is_available'];
    sku = json['sku'];
    name = json['name'];
    price =
    json['price'] != null ? new ShippingCost.fromJson(json['price']) : null;
    salePrice = json['sale_price'] != null
        ? new ShippingCost.fromJson(json['sale_price'])
        : null;
    currency = json['currency'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    hasSpecialPrice = json['has_special_price'];
    regularPrice = json['regular_price'] != null
        ? new SubTotal.fromJson(json['regular_price'])
        : null;
    calories = json['calories'];
    mpn = json['mpn'];
    gtin = json['gtin'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.promotion != null) {
      data['promotion'] = this.promotion!.toJson();
    }
    data['status'] = this.status;
    data['is_available'] = this.isAvailable;
    data['sku'] = this.sku;
    data['name'] = this.name;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.salePrice != null) {
      data['sale_price'] = this.salePrice!.toJson();
    }
    data['currency'] = this.currency;
    data['url'] = this.url;
    data['thumbnail'] = this.thumbnail;
    data['has_special_price'] = this.hasSpecialPrice;
    if (this.regularPrice != null) {
      data['regular_price'] = this.regularPrice!.toJson();
    }
    data['calories'] = this.calories;
    data['mpn'] = this.mpn;
    data['gtin'] = this.gtin;
    data['favorite'] = this.favorite;
    return data;
  }
}

class Promotion {
  var title;
  var subTitle;

  Promotion({this.title, this.subTitle});

  Promotion.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    return data;
  }
}

class Options {
  int? id;
  int? productOptionId;
  String? name;
  String? type;
  Value? value;

  Options({this.id, this.productOptionId, this.name, this.type, this.value});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productOptionId = json['product_option_id'];
    name = json['name'];
    type = json['type'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_option_id'] = this.productOptionId;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class Value {
  int? id;
  String? name;
  ShippingCost? price;

  Value({this.id, this.name, this.price});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price =
    json['price'] != null ? new ShippingCost.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? count;
  int? total;
  int? perPage;
  int? currentPage;
  int? totalPages;
  Links? links;

  Pagination(
      {this.count,
        this.total,
        this.perPage,
        this.currentPage,
        this.totalPages,
        this.links});

  Pagination.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    total = json['total'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total'] = this.total;
    data['perPage'] = this.perPage;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Links {
  String? next;
  String? previous;

  Links({this.next,this.previous});

  Links.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    data['previous'] = this.previous;
    return data;
  }
}