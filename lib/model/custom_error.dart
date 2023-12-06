import 'dart:core';

class CustomError {
  int? timeStamp;
  String? url;
  String? request;
  String? response;

  CustomError({this.timeStamp, this.url, this.request, this.response});

  CustomError.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    url = json['url'];
    request = json['request'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timeStamp'] = DateTime.now().millisecondsSinceEpoch;
    data['url'] = this.url;
    data['request'] = this.request;
    data['response'] = response;
    return data;
  }
}
