import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/book/book_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ListBooks extends View {
  @override
  _ListBooksState createState() => _ListBooksState();
}

class _ListBooksState extends ViewState<ListBooks, BookController> {

  @override
  void initState() {
    controller.getListBooks();
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
                'My booking states'
            ),
          ),
          body: ListView.builder(
              itemCount: controller.listBooks.length,
              itemBuilder: (context, index) {
                final String _rentedTime = DateFormat('kk:mm  dd-MM-yyyy').format(controller.listBooks[index].rentedTime.toDate());
                final String _returnTime= DateFormat('kk:mm  dd-MM-yyyy').format(controller.listBooks[index].returnTime.toDate());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new GestureDetector(
                    onTap: (){
                      Get.toNamed(
                          Routes.BOOKDETAILS,
                          arguments: controller.listBooks[index].idUserState
                      );
                    },
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(
                              width: 3,
                              color: controller.listBooks[index].notUsed== null ? Colors.green : Colors.red
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            text(controller.listBooks[index].namePL),
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
            callback: () => controller.getListBooks()
        ) : Container()
      ],
    ));
  }
}
