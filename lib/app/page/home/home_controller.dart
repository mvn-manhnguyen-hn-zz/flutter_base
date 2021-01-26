import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/entities/rank_top_model.dart';
import 'package:flutter_base/domain/entities/shop_model.dart';
import 'package:flutter_base/domain/interfaces/invoice_interface.dart';
import 'package:flutter_base/domain/interfaces/proflie_interfaces.dart';
import 'package:flutter_base/domain/interfaces/rank_top_interface.dart';
import 'package:flutter_base/domain/interfaces/shop_interfaces.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';


class HomeController extends Controller {
  /// create a reactive status from request with initial value = loading
  final ShopInterface shopInterface;
  final RankTopInterface rankTopInterface;
  final ProfileInterface profileInterface;
  final InvoiceInterface invoiceInterface;
  HomeController({
    @required this.shopInterface,
    @required this.rankTopInterface,
    @required this.profileInterface,
    @required this.invoiceInterface
});
  final listShop = List<ShopModel>().obs;
  final RxInt selectIndex = 0.obs;
  final thisArg = List<Before>().obs;
  final Rx<ProfileModel> information = Rx<ProfileModel>();
  final Rx<String> endBankAccount = Rx<String>();

  void onItemTapped(int index){
    selectIndex(index);
  }

  Future<void> fetchListShop({Callback callback}) async {
    status(Status.loading);
    shopInterface.getListShop().then(
          (data) {
        listShop.clear();
        listShop.addAll(data);
        status(Status.success);
        callback?.call();
      },
      onError: (err) {
        status(Status.error);
      },
    );
  }

  Future<void> fetchRankTopData({Callback callback}) async {
    status(Status.loading);
    rankTopInterface.getRankTop().then((value) async {
      await value.sort((a,b) => b.ranking.compareTo(a.ranking));
      thisArg(value);
      status(Status.success);
      callback?.call();
    },
      onError: (err) {
        status(Status.error);
      },
    );
  }

  Future<void> fetchInformation({VoidCallback callback}) async {
    status(Status.loading);
    profileInterface.getInformation().then((value) {
      final ProfileModel profileModel = information(value);
      final getEndBankAccount = profileModel.bankAccount.characters.getRange(
          profileModel.bankAccount.length-9,
          profileModel.bankAccount.length
      );
      endBankAccount(getEndBankAccount.toString());
      status(Status.success);
      callback?.call();
    },
      onError: (err) {
        status(Status.error);
      },
    );
  }

  Future fetchListInvoice() async {
    //status(Status.loading);
    // invoiceInterface.getInvoice().then((value){
    //   if (value == null){
    //     print('no value');
    //   }
    // });
  }

  @override
  void onConnected() {
    super.onConnected();
  }
}
