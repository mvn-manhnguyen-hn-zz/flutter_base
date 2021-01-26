import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/home/home_controller.dart';

class InvoiceView extends View {
  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends ViewState<InvoiceView, HomeController> {

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.filter_alt_outlined),
              onPressed: (){
                controller.fetchListInvoice();
              }
          )
        ],
      ),
      body: Center(
        child: Text('Đơn hàng'),
      ),
    );
  }
}
