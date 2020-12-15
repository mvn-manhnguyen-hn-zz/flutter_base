class RankTopModel {
  List<Before> before;
  List<Before> thisArg;

  RankTopModel({this.before, this.thisArg});

  RankTopModel.fromJson(Map<String, dynamic> json) {
    if (json['before'] != null) {
      before = new List<Before>();
      json['before'].forEach((v) {
        before.add(new Before.fromJson(v));
      });
    }
    if (json['this'] != null) {
      thisArg = new List<Before>();
      json['this'].forEach((v) {
        before.add(new Before.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.before != null) {
      data['before'] = this.before.map((v) => v.toJson()).toList();
    }
    if (this.thisArg != null) {
      data['this'] = this.thisArg.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Before {
  int ranking;
  int userId;
  String avatar;
  String name;
  int total;

  Before({this.ranking, this.userId, this.avatar, this.name, this.total});

  Before.fromJson(Map<String, dynamic> json) {
    ranking = json['ranking'];
    userId = json['user_id'];
    avatar = json['avatar'];
    name = json['name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ranking'] = this.ranking;
    data['user_id'] = this.userId;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['total'] = this.total;
    return data;
  }
}
