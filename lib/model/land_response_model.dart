import 'dart:convert';

LandResponseModel landResponseModelFromJson(String str) =>
    LandResponseModel.fromJson(json.decode(str));

String landResponseModelToJson(LandResponseModel data) =>
    json.encode(data.toJson());

class LandResponseModel {
  LandResponseModel({
    this.data,
  });

  LandResponseData? data;

  factory LandResponseModel.fromJson(Map<String, dynamic> json) =>
      LandResponseModel(
        data: json["data"] == null
            ? null
            : LandResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class LandResponseData {
  LandResponseData({
    this.landData,
  });

  LandData? landData;

  factory LandResponseData.fromJson(Map<String, dynamic> json) =>
      LandResponseData(
        landData: json["landData"] == null
            ? null
            : LandData.fromJson(json["landData"]),
      );

  Map<String, dynamic> toJson() => {
        "landData": landData?.toJson(),
      };
}

class LandData {
  LandData({
    this.count,
    this.totalPages,
    this.currentPageNumber,
    this.results,
  });

  int? count;
  int? totalPages;
  int? currentPageNumber;
  List<LandResult>? results;

  factory LandData.fromJson(Map<String, dynamic> json) => LandData(
        count: json["count"],
        totalPages: json["totalPages"],
        currentPageNumber: json["currentPageNumber"],
        results: json["results"] == null
            ? []
            : List<LandResult>.from(
                json["results"]!.map((x) => LandResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "totalPages": totalPages,
        "currentPageNumber": currentPageNumber,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class LandResult {
  LandResult({
    this.id,
    this.city,
    this.area,
    this.latitude,
    this.longitude,
    this.parcelId,
    this.wardNo,
    this.district,
    this.address,
    this.surveyNo,
    this.province,
    this.landPrice,
    this.isVerified,
    this.ownerUserId,
    this.ownerHistory,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.polygon,
  });

  String? id;
  String? city;
  String? area;
  String? latitude;
  String? longitude;
  String? parcelId;
  String? wardNo;
  String? district;
  String? address;
  String? surveyNo;
  String? province;
  String? landPrice;
  String? isVerified;
  String? ownerUserId;
  List<String>? ownerHistory;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<Polygon>? polygon;

  factory LandResult.fromJson(Map<String, dynamic> json) => LandResult(
        id: json["_id"],
        city: json["city"],
        area: json["area"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        parcelId: json["parcelId"],
        wardNo: json["wardNo"],
        district: json["district"],
        address: json["address"],
        surveyNo: json["surveyNo"],
        province: json["province"],
        landPrice: json["landPrice"],
        isVerified: json["isVerified"],
        ownerUserId: json["ownerUserId"],
        ownerHistory: json["ownerHistory"] == null
            ? []
            : List<String>.from(json["ownerHistory"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        polygon: json["polygon"] == null
            ? []
            : List<Polygon>.from(
                json["polygon"]!.map((x) => Polygon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "city": city,
        "area": area,
        "latitude": latitude,
        "longitude": longitude,
        "parcelId": parcelId,
        "wardNo": wardNo,
        "district": district,
        "address": address,
        "surveyNo": surveyNo,
        "province": province,
        "landPrice": landPrice,
        "isVerified": isVerified,
        "ownerUserId": ownerUserId,
        "ownerHistory": ownerHistory == null
            ? []
            : List<dynamic>.from(ownerHistory!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "polygon": polygon == null
            ? []
            : List<dynamic>.from(polygon!.map((x) => x.toJson())),
      };
}

class Polygon {
  Polygon({
    this.latitude,
    this.longitude,
    this.id,
  });

  String? latitude;
  String? longitude;
  String? id;

  factory Polygon.fromJson(Map<String, dynamic> json) => Polygon(
        latitude: json["latitude"],
        longitude: json["longitude"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "_id": id,
      };
}
