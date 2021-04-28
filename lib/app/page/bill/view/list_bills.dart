import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/bill/bill_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListBills extends View {
  @override
  _ListBillsState createState() => _ListBillsState();
}

class _ListBillsState extends ViewState<ListBills, BillController> {

  @override
  void initState() {
    controller.getListBills();
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                'All bill'
            ),
          ),
          body: ListView.builder(
              itemCount: controller.listBills.length,
              itemBuilder: (context, index) {
                final String _rentedTime = DateFormat('kk:mm  dd-MM-yyyy').format(controller.listBills[index].rentedTime.toDate());
                final String _returnTime= DateFormat('kk:mm  dd-MM-yyyy').format(controller.listBills[index].returnTime.toDate());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new GestureDetector(
                    onTap: (){
                      Get.offNamed(
                          Routes.BILLDETAILS,
                          arguments: controller.listBills[index].idBill
                      );
                    },
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(
                              width: 3,
                              color: Colors.green
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            text(controller.listBills[index].namePL),
                            text('From: $_rentedTime'),
                            text('To: $_returnTime')
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
        loading(
            status: controller.status.value,
            context: context
        ),
        controller.status.value == Status.error ? buttonError(
            callback: () => controller.getListBills()
        ) : Container()
      ],
    ));
  }
}
