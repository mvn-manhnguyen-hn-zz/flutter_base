import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/case_model.dart';
import 'package:flutter_base/domain/interfaces/home_interfaces.dart';
import 'package:get/get.dart';

enum Status { loading, success, error }

class HomeController extends Controller {
  HomeController({this.homeInterface});

  /// inject repo abstraction dependency
  final HomeInterface homeInterface;

  /// create a reactive status from request with initial value = loading
  final status = Status.loading.obs;

  /// create a reactive CasesModel. CasesModel().obs has same result
  final cases = Rx<CasesModel>();

  /// When the controller is initialized, make the http request
  @override
  void onInit() => fetchDataFromApi();

  /// fetch cases from Api
  Future<void> fetchDataFromApi() async {
    /// When the repository returns the value, change the status to success,
    /// and fill in "cases"
    return homeInterface.getCases().then(
      (data) {
        cases(data);
        status(Status.success);
      },

      /// In case of error, print the error and change the status
      /// to Status.error
      onError: (err) {
        print("$err");
        return status(Status.error);
      },
    );
  }

  @override
  void onConnected() {
    fetchDataFromApi();
    super.onConnected();
  }
}
