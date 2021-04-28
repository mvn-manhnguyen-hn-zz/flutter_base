import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/rent/rent_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListRents extends View {
  @override
  _ListRentsState createState() => _ListRentsState();
}

class _ListRentsState extends ViewState<ListRents, RentController> {

  @override
  void initState() {
    controller.getListRents();
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
                'My rental states'
            ),
          ),
          body: ListView.builder(
              itemCount: controller.listRents.length,
              itemBuilder: (context, index) {
                final String _rentedTime = DateFormat('kk:mm  dd-MM-yyyy').format(controller.listRents[index].rentedTime.toDate());
                final String _returnTime= DateFormat('kk:mm  dd-MM-yyyy').format(controller.listRents[index].returnTime.toDate());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new InkWell(
                    onTap: (){
                      Get.toNamed(
                          Routes.RENTDETAILS,
                          arguments: controller.listRents[index].idUserState
                      );
                    },
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(
                              width: 3,
                              color: controller.listRents[index].notUsed ? Colors.red : Colors.green
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            text(controller.listRents[index].namePL),
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
            callback: () => controller.getListRents()
        ) : Container()
      ],
    ));
  }
}
