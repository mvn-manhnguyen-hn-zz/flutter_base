class ErrorModel {
  List<dynamic> errors;
  String message;

  ErrorModel({this.errors, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    errors = json['errors'];
    message = json['message'];
  }
}
