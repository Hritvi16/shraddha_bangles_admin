class Response {
  String message;

  Response({
    this.message,
  });

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['message'] = this.message;

    return map;
  }
}
