import 'package:flutter_base/domain/entities/rank_top_model.dart';

abstract class RankTopInterface{
  Future<List<Before>> getRankTop();
}
