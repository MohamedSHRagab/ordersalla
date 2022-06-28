
import 'Data.dart';

class  ProductModel2 {
  String? name;
  String? metatype;
  String? comment;
  String? translationid;
  String? errors;
  List<DataModel>? data;

  ProductModel2(
      {this.name,
        this.metatype,
        this.comment,
        this.translationid,
        this.errors,
        this.data});

  ProductModel2.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    metatype = json['metatype'];
    comment = json['comment'];
    translationid = json['translationid'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(new DataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['metatype'] = this.metatype;
    data['comment'] = this.comment;
    data['translationid'] = this.translationid;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


