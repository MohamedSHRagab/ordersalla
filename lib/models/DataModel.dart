import 'package:ordersalla/models/voucher/ProductModel.dart';

class DataModel2 {
  int? id;
  int? referenceId;
  Urls? urls;
  Date? date;
  var source;
  var sourceDevice;
  SourceDetails? sourceDetails;
  Date? firstCompleteAt;
  Status? status;
  var paymentMethod;
  var currency;
  Amounts? amounts;
  Shipping? shipping;
  bool? canCancel;
  bool? showWeight;
  bool? canReorder;
  bool? isPendingPayment;
  var pendingPaymentEndsAt;
  var totalWeight;
  List<ShipmentBranch>? shipmentBranch;
  Customer? customer;
  List<Items>? items;
  Null? bank;
  List<Null>? tags;

  DataModel2(
      {this.id,
        this.referenceId,
        this.urls,
        this.date,
        this.source,
        this.sourceDevice,
        this.sourceDetails,
        this.firstCompleteAt,
        this.status,
        this.paymentMethod,
        this.currency,
        this.amounts,
        this.shipping,
        this.canCancel,
        this.showWeight,
        this.canReorder,
        this.isPendingPayment,
        this.pendingPaymentEndsAt,
        this.totalWeight,
        this.shipmentBranch,
        this.customer,
        this.items,
        //this.bank,
        });

  DataModel2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    source = json['source'];
    sourceDevice = json['source_device'];
    sourceDetails = json['source_details'] != null
        ? new SourceDetails.fromJson(json['source_details'])
        : null;
    firstCompleteAt = json['first_complete_at'] != null
        ? new Date.fromJson(json['first_complete_at'])
        : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    paymentMethod = json['payment_method'];
    currency = json['currency'];
    amounts =
    json['amounts'] != null ? new Amounts.fromJson(json['amounts']) : null;
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    canCancel = json['can_cancel'];
    showWeight = json['show_weight'];
    canReorder = json['can_reorder'];
    isPendingPayment = json['is_pending_payment'];
    pendingPaymentEndsAt = json['pending_payment_ends_at'];
    totalWeight = json['total_weight'];
    if (json['shipment_branch'] != null) {
      shipmentBranch = <ShipmentBranch>[];
      json['shipment_branch'].forEach((v) {
        shipmentBranch!.add(new ShipmentBranch.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    //bank = json['bank'];
    /* if (json['tags'] != null) {
      tags = <Null>[];
      json['tags'].forEach((v) {
        tags!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_id'] = this.referenceId;
    if (this.urls != null) {
      data['urls'] = this.urls!.toJson();
    }
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    data['source'] = this.source;
    data['source_device'] = this.sourceDevice;
    if (this.sourceDetails != null) {
      data['source_details'] = this.sourceDetails!.toJson();
    }
    if (this.firstCompleteAt != null) {
      data['first_complete_at'] = this.firstCompleteAt!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['payment_method'] = this.paymentMethod;
    data['currency'] = this.currency;
    if (this.amounts != null) {
      data['amounts'] = this.amounts!.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    data['can_cancel'] = this.canCancel;
    data['show_weight'] = this.showWeight;
    data['can_reorder'] = this.canReorder;
    data['is_pending_payment'] = this.isPendingPayment;
    data['pending_payment_ends_at'] = this.pendingPaymentEndsAt;
    data['total_weight'] = this.totalWeight;
    if (this.shipmentBranch != null) {
      data['shipment_branch'] =
          this.shipmentBranch!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    //data['bank'] = this.bank;
    /* if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}
