
import 'package:flutter_base/domain/entities/profile_model.dart';

abstract class ProfileInterface{
  Future<ProfileModel> getInformation();
}