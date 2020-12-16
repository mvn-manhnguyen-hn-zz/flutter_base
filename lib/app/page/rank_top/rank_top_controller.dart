import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/rank_top_model.dart';
import 'package:flutter_base/domain/interfaces/rank_top_interface.dart';
import 'package:get/get.dart';

class RankTopController extends Controller {
  RankTopController({this.rankTopInterface});
  final RankTopInterface rankTopInterface;
  final Rx<List<Before>> thisArg = Rx<List<Before>>();

  Future<void> fetchRankTopData({VoidCallback callback}) async {
    status(Status.loading);
    rankTopInterface.getRankTop().then(
      (value) async {
        await value.sort((a, b) => b.ranking.compareTo(a.ranking));
        thisArg(value);
        status(Status.success);
        callback?.call();
      },
      onError: (err) {
        status(Status.error);
      },
    );
  }
}
