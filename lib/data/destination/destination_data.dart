import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  String name;
  GeoPoint location;
  Destination({this.name, this.location});
}

List<Destination> destinationData = [
  Destination(name: 'Landmark Tower', location: GeoPoint(21.016936, 105.783837)),
  Destination(name: 'Bệnh viện nhi trung ương', location: GeoPoint(21.025174, 105.807311)),
  Destination(name: 'KFC Xã Đàn', location: GeoPoint(21.016963, 105.831886)),
  Destination(name: 'Hồ Gươm', location: GeoPoint(21.031067, 105.852397)),
  Destination(name: 'Bến xe Giáp Bát', location: GeoPoint(20.980490, 105.841799)),
  Destination(name: 'Thiên đường Bảo Sơn', location: GeoPoint(20.999338, 105.733461)),
  Destination(name: 'Lăng chủ tịch Hồ Chí Minh', location: GeoPoint(21.037123, 105.834700)),
  Destination(name: 'Nhà thờ Lớn Hà Nội', location: GeoPoint(21.028765, 105.848842)),
  Destination(name: 'Chợ Phùng Khoang', location: GeoPoint(20.987053, 105.793720)),
  Destination(name: 'Sân bóng Định Công', location: GeoPoint(20.981769, 105.827528)),
  Destination(name: 'Bệnh viện K', location: GeoPoint(21.026996, 105.846011)),
  Destination(name: 'Bệnh viện đa khoa phương đông', location: GeoPoint(21.071584, 105.775272)),
  Destination(name: 'Chợ đồng xuân', location: GeoPoint(21.041204, 105.850254)),
  Destination(name: 'Time City', location: GeoPoint(20.995279, 105.869225)),
  Destination(name: 'Royal City', location: GeoPoint(21.002207, 105.815190)),
  Destination(name: 'Hồ Tây', location: GeoPoint(21.055578, 105.819740)),
  Destination(name: 'Công viên Thủ Lệ', location: GeoPoint(21.030768, 105.805524)),
  Destination(name: 'SVĐ Mỹ Đình', location: GeoPoint(21.020664, 105.763120)),
  Destination(name: 'Monstar Lab', location: GeoPoint(21.012040, 105.775130)),
  Destination(name: 'SVĐ Bách Khoa', location: GeoPoint(21.002394, 105.847832)),
];
