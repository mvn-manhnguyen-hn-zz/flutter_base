import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/widgets/colors.dart';
import 'package:flutter_base/app/widgets/text_style.dart';
import '../product_controller.dart';

class ListCategory extends View {
  @override
  _ListCategoryState createState() => _ListCategoryState();
}

class _ListCategoryState extends ViewState<ListCategory, ProductController> {

  @override
  void initState() {
    super.initState();
  }

  void addListProductChose(String category){
    final listProductChose = controller.listProduct.where((e) => e.categoryName.contains(category));
    controller.listProductFilter.addAll(listProductChose);
  }

  void removeListProductChose(String category){
    controller.listProductFilter.removeWhere((element) => element.categoryName.contains(category));
  }

  Widget category(String name, bool isChose){
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: isChose ? backgroundColor : primaryColor,
                width: 2
            ),
            color: isChose ? primaryColor : backgroundColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: Style.article1TextStyle.copyWith(
                color: isChose ? backgroundColor : primaryColor
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: white, width: 2),
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Wrap(
            children: controller.listCategory.toList().map((element) =>
                InkWell(
                  onTap: (){
                    setState(() {
                      element.isChose = !element.isChose;
                    });
                    if (element.isChose) {
                      addListProductChose(element.name);
                    } else {
                      removeListProductChose(element.name);
                    }
                  },
                  child: category(element.name, element.isChose),
                )
            ).toList(),
          )
        ],
      ),
    );
  }
}
