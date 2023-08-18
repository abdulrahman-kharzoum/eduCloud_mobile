class location {
  Data? data;

  location({this.data});

  location.fromJson(Map json) {
    print("Location FROM JSON");
    print(json);
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Location? location;
  Location? startingPoint;
  Location? endingPoint;

  Data({this.location, this.startingPoint, this.endingPoint});

  Data.fromJson(Map<String, dynamic> json) {
    location = json['Location'] != null
        ? new Location.fromJson(json['Location'])
        : null;
    startingPoint = json['StartingPoint'] != null
        ? new Location.fromJson(json['StartingPoint'])
        : null;
    endingPoint = json['EndingPoint'] != null
        ? new Location.fromJson(json['EndingPoint'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['Location'] = this.location!.toJson();
    }
    if (this.startingPoint != null) {
      data['StartingPoint'] = this.startingPoint!.toJson();
    }
    if (this.endingPoint != null) {
      data['EndingPoint'] = this.endingPoint!.toJson();
    }
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;
  String? message;

  Location({this.latitude, this.longitude, this.message});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['message'] = this.message;
    return data;
  }
}
