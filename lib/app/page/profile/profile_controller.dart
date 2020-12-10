


import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/interfaces/proflie_interfaces.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProfileController extends Controller {
  ProfileController({@required this.profileInterface});

  final ProfileInterface profileInterface;

  final Rx<ProfileModel> information = Rx<ProfileModel>();

  Future<void> fetchInformation({VoidCallback callback}) async {
    status(Status.loading);
    profileInterface.getInformation().then((value) {
      print(value.name);
      information(value);
      status(Status.success);
      callback?.call();
    },
      onError: (err) {
        status(Status.error);
      },
    );
    @override
    void onConnected() {
      super.onConnected();
    }
  }
}