// "id": 1,
//   "name": "Nguyen Van A",
//   "facebook_nickname": "https://m.facebook.com/profile.php?_rdr",
//   "phone": "0123456789",
//   "avatar": "https://shopmede.com/images/logo.svg",
//   "bank_name": "NH Vcb",
//   "branch_name": "CN thang long",
//   "bank_account": "19033287571018",
//   "bank_owner_account": "Nguyen Van A",
//   "role": "1",
//   "nicknames": [
//     "shopmede"
//   ],
//   "created_at": 1560913493
// class ProfileModel {
//   int id;
//   String name;
//   String facebook_nickname;
//   String phone;
//   String avatar;
//   String bank_name;
//   String branch_name;
//   String bank_account;
//   String bank_owner_account;
//   int role;
//   List<String> nicknames;
//   String created_at;

//   ProfileModel(
//       {this.id,
//       this.name,
//       this.facebook_nickname,
//       this.phone,
//       this.avatar,
//       this.bank_name,
//       this.bank_account,
//       this.bank_owner_account,
//       this.role,
//       this.nicknames,
//       this.created_at});

//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     facebook_nickname = json['facebook_nickname'];
//     phone = json['phone'];
//     avatar = json['avatar'];
//     bank_name = json['bank_name'];
//     bank_account = json['bank_account'];
//     bank_owner_account = json['bank_owner_account'];
//     role = json['role'];
//     nicknames = [];
//     created_at = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['facebook_nickname'] = this.facebook_nickname;
//     data['phone'] = this.phone;
//     data['avatar'] = this.avatar;
//     data['bank_name'] = this.bank_name;
//     data['bank_account'] = this.bank_account;
//     data['bank_owner_account'] = this.bank_owner_account;
//     data['role'] = this.role;
//     data['nicknames'] = this.nicknames;
//     data['created_at'] = this.created_at;
//     return data;
//   }
// }
class ProfileModel {
  int id;
  String name;
  String facebookNickname;
  String phone;
  String avatar;
  String bankName;
  String branchName;
  String bankAccount;
  String bankOwnerAccount;
  int role;
  List<String> nicknames;
  int createdAt;

  ProfileModel(
      {this.id,
      this.name,
      this.facebookNickname,
      this.phone,
      this.avatar,
      this.bankName,
      this.branchName,
      this.bankAccount,
      this.bankOwnerAccount,
      this.role,
      this.nicknames,
      this.createdAt});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    facebookNickname = json['facebook_nickname'];
    phone = json['phone'];
    avatar = json['avatar'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    bankAccount = json['bank_account'];
    bankOwnerAccount = json['bank_owner_account'];
    role = json['role'];
    nicknames = json['nicknames'].cast<String>();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['facebook_nickname'] = this.facebookNickname;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['bank_account'] = this.bankAccount;
    data['bank_owner_account'] = this.bankOwnerAccount;
    data['role'] = this.role;
    data['nicknames'] = this.nicknames;
    data['created_at'] = this.createdAt;
    return data;
  }
}
