import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:ordersalla/models/Product.dart';
import 'package:ordersalla/models/voucher/ProductModel.dart';

import 'dart:convert';

import '../../network/ApiUrl.dart';
import '../../network/HttpClient.dart';
import '../models/RecieveModel.dart';
import '../models/RecieveModel2.dart';
import '../models/RecieveStartModel.dart';
import '../models/SendResponse.dart';
import '../models/voucher/Data.dart';
import '../models/voucher/ProductModel2.dart';
import '../models/voucher/Store.dart';
import '../models/DataModel.dart';

class Voucher_screen extends StatefulWidget {
  @override
  _Voucher_screenState createState() => _Voucher_screenState();
}

class _Voucher_screenState extends State<Voucher_screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHiddenPassword = true;

  bool allcheck = false;
  List<DataModel2> itemsList = [];
  bool loading = true;
  OrdersModel rm = OrdersModel();
int pagenum=3;
  @override
  void initState() {
    super.initState();
    getdata(pagenum);
  }

  getdata(int pagenum) {

    HttpClient()
        .get(ApiUrl.apiUrl + 'orders?expanded=false&page=$pagenum', headers: <String, String>{
      'Authorization': ApiUrl.tocken,
      'Content-Type': 'application/json',
      'Accept': 'application/json, version=2',
      //'Auth-Nonce': ApiUrl.auth_nonce,
      //'Auth-Nonce-Response': ApiUrl.auth_nonce_response,
      'Accept-Language':
          'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
    }).then((value) {
      setState(() {
        loading = false;
      });
      print(value);
      print(pagenum);

      rm = OrdersModel.fromJson(value);
      itemsList = rm.data!;

      print(itemsList.length.toString());

      setState(() {
      });

      // products_list.clear();
    });
  }

  Future<String> getitemsid(String sku) async {
    setState(() {
      loading = true;
    });
    String response = "";
    await HttpClient().get(
        ApiUrl.authUrl +
            'api/backoffice/inventory?cols=*&filter=(alu,eq,"$sku")AND(active,eq,true) ',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json, version=2',
          'Auth-Session': ApiUrl.auth_session,
          //'Auth-Nonce': ApiUrl.auth_nonce,
          //'Auth-Nonce-Response': ApiUrl.auth_nonce_response,
          'Accept-Language':
              'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
        }).then((value) {
      setState(() {
        loading = false;
      });
      ProductModel2 rm = ProductModel2.fromJson(value);
      List<DataModel> itemsList = rm.data!;
      response = itemsList[0].sid;
    });
    return response;
  }

  sendItems(List<String> items_sid, DataModel2 order, BuildContext context) async {
    setState(() {
      loading = true;
    });
    var sent = [
      {
        "so_deposit_amt_paid": order.amounts!.subTotal!.amount,
        "taken_amt": order.amounts!.subTotal!.amount,
        "doc_tender_type": 4,
        "notes_general": order.id,
        "origin_application": "SallaAPI",
        "due_amt": 0,
        "bt_cuid": "636554017000197199",
        "store_uid": "551044820000192262",
        "original_store_uid": "551044820000192262",
        "fulfill_store_sid": "551044820000192262",
        "subsidiary_uid": "551044820000189257",
        "receipt_type": 2,
        "order_type": 0,
        "order_status": 0,
        "tax_area_percent": 15,
        "tax_area2_percent": 0,
        "shipping_amt": 0,
        "shipping_amt_manual": 0,
        "items": [
          for (int i = 0; i < order.items!.length; i++)
            {
              "origin_application": " SallaAPI ",
              "item_type": 3,
              "order_type": 0,
              "invn_sbs_item_sid": items_sid[i],
              "quantity": order.items![i].quantity
            },
        ],
        "tenders": [
          {
            "origin_application": "SallaAPI",
            "taken": order.amounts!.subTotal!.amount,
            "tender_type": 4,
            "tender_name": "COD"
          }
        ]
      }
    ];   var updatestatue = [
      {
        "statue":4
      }
    ];
    await HttpClient().post(ApiUrl.authUrl + 'v1/rest/document',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json, version=2',
          'Auth-Session': ApiUrl.auth_session,
          'Accept-Language':
              'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
        },        body: json.encode(sent),
    ).then((value) async {
      print(value);
      setState(() {
        loading = true;
      });
      //SendResponse rm = SendResponse.fromJson(value);
      print(value[0]["sid"]);
      await HttpClient().put(ApiUrl.authUrl + 'v1/rest/document/'+value[0]["sid"]+"?cols=*&filter=row_version,eq,3",
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json, version=2',
          'Auth-Session': ApiUrl.auth_session,
          'Accept-Language':
          'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
        },        body: json.encode(updatestatue),
      ).then((value) {
        print(value);
        setState(() {
          loading = false;
        });
       // if(value==null){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: Colors.green,
                    content: Container(
                      height: 200,
                      width: 300,
                      child: Center(
                        child: Text(
                          "Orders Items Sent Sucessfully To Prism ",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ));
              });
       /* }else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: Colors.red,
                    content: Container(
                      height: 200,
                      width: 300,
                      child: Center(
                        child: Text(
                           "Orders Items Sent failed To send to Prism ",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ));
              });
        }*/
        //SendResponse rm = SendResponse.fromJson(value);
        print(value[0]["sid"]);

      }).onError((error, stackTrace) {
        print(error.toString());
      });
    /*  showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                backgroundColor: Colors.green,
                content: Container(
                  height: 200,
                  width: 300,
                  child: Center(
                    child: Text(
                      value.headers["sid"] != null
                          ? value
                          : "Orders Items Sent Sucessfully To Prism ",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ));
          });*/
      // products_list.clear();
      //setState(() {});
    }).onError((error, stackTrace) {
        print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> coulmns = [
      "Orders list",
    ];
    bool initial = false;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(bottom: 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Salla Orders",
                            style: TextStyle(
                                fontSize: 40,
                                color: Color.fromRGBO(26, 61, 109, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  for (int i = 0; i < coulmns.length; i++)
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white60,
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color.fromRGBO(26, 61, 109, 1),
                                              Color.fromRGBO(38, 88, 187, 1),
                                            ],
                                          )),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              coulmns[i],
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          )),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 1,
                                                color: Colors.black),
                                    itemCount: itemsList.length,
                                    itemBuilder: (context, index) {
                                      return ExpansionTile(
                                          initiallyExpanded: initial,
                                          onExpansionChanged: (bool) {
                                            setState(() {
                                              initial = bool;
                                            });
                                          },
                                          title: Center(
                                              child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      "Order Id : " +
                                                          itemsList[index]
                                                              .id
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        List<String> items_sid =
                                                            [];
                                                        for (int i = 0;
                                                            i <
                                                                itemsList[index]
                                                                    .items!
                                                                    .length;
                                                            i++) {
                                                          getitemsid(itemsList[
                                                                      index]
                                                                  .items![i]
                                                                  .sku)
                                                              .then((value) async {
                                                            print(value);
                                                            items_sid
                                                                .add(value);
                                                            if (i ==
                                                                itemsList[index]
                                                                        .items!
                                                                        .length -
                                                                    1) {
                                                              sendItems(
                                                                  items_sid,
                                                                  itemsList[
                                                                      index],
                                                                  context);
                                                            }
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                border: Border.all(
                                                                    color: Colors.white,
                                                                    width: 0.0),
                                                                // Set border width
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                                // Set rounded corner radius
                                                                boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 3,
                                                                  color: Colors
                                                                      .green,
                                                                  offset:
                                                                      Offset(
                                                                          1, 3))
                                                            ] // Make rounded corner of border
                                                                ),
                                                        child: Text(
                                                          "Send to Prism ",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                "Customer Id : " +
                                                    itemsList[index]
                                                        .customer!
                                                        .id
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87),
                                              ),
                                              Text(
                                                "Customer Name : " +
                                                    itemsList[index]
                                                        .customer!
                                                        .firstName +
                                                    " " +
                                                    itemsList[index]
                                                        .customer!
                                                        .lastName,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87),
                                              ),
                                              Text(
                                                "Order Total : " +
                                                    itemsList[index]
                                                        .amounts!
                                                        .total!
                                                        .amount
                                                        .toString() +
                                                    " " +
                                                    itemsList[index]
                                                        .amounts!
                                                        .total!
                                                        .currency
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87),
                                              ),
                                              Text(
                                                "Tax Amount  : " +
                                                    itemsList[index]
                                                        .amounts!
                                                        .tax!
                                                        .amount!
                                                        .amount
                                                        .toString() +
                                                    " " +
                                                    itemsList[index]
                                                        .amounts!
                                                        .tax!
                                                        .amount!
                                                        .currency
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87),
                                              ),
                                              Text(
                                                "Shipping Amount : " +
                                                    itemsList[index]
                                                        .amounts!
                                                        .shippingCost!
                                                        .amount
                                                        .toString() +
                                                    " " +
                                                    itemsList[index]
                                                        .amounts!
                                                        .shippingCost!
                                                        .currency
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          )),
                                          subtitle: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    itemsList[index]
                                                            .items!
                                                            .length
                                                            .toString() +
                                                        " Items",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black87)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    itemsList[index]
                                                        .status!
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87)),
                                              ],
                                            ),
                                          ),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    itemsList[index]
                                                        .items!
                                                        .length;
                                                i++)
                                              ListTile(
                                                leading: Text(itemsList[index]
                                                    .items![i]
                                                    .name
                                                    .toString()),
                                                trailing: Text(itemsList[index]
                                                    .items![i]
                                                    .sku
                                                    .toString()),
                                                subtitle: Text("QTY : " +
                                                    itemsList[index]
                                                        .items![i]
                                                        .quantity
                                                        .toString() +
                                                    "  ".toString()),
                                              ),
                                          ]);

                                      return Container(
                                        color: index % 2 == 0
                                            ? Colors.white
                                            : Colors.black12,
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Checkbox(
                                                value: allcheck,
                                                onChanged: (value) {
                                                  print(value!);

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Text(
                                                    itemsList[index]
                                                        .id
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Text(
                                                    itemsList[index]
                                                        .status!
                                                        .name
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Text(
                                                    itemsList[index]
                                                        .date!
                                                        .date
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Text(
                                                    itemsList[index]
                                                        .items!
                                                        .length
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Text(
                                                    itemsList[index]
                                                            .customer!
                                                            .firstName
                                                            .toString() +
                                                        " " +
                                                        itemsList[index]
                                                            .customer!
                                                            .lastName
                                                            .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        bottomSheet: Container(
          height: 45,
          child: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  for (int i = 0;
                      i < double.parse(rm.pagination!.totalPages.toString());
                      i++)
                    InkWell(
                      onTap: (){
                      pagenum= i+1;
                      setState(() {
                        loading = true;
                      });
                        getdata(pagenum);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.white, width: 0.0),
                            // Set border width
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            // Set rounded corner radius
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.blue,
                                  offset: Offset(1, 3))
                            ] // Make rounded corner of border
                            ),
                        child: Text(
                          "page " + (i + 1).toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              scrollDirection: Axis.horizontal),
        ),
      ),
    );
  }

  Color linear = Colors.white;

  Widget inputItem(BuildContext context, String text,
      TextEditingController txtControl, List<String> data,
      {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: EasyAutocomplete(
                controller: txtControl,
                suggestions: data,
                onChanged: (value) => print('onChanged value: $value'),
                onSubmitted: (value) {},
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget inputItem2(
      String text, TextEditingController txtControl, bool editable,
      {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: TextField(
              controller: txtControl,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              enabled: editable,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(26, 61, 109, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
