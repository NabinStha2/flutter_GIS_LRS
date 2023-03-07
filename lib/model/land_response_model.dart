// To parse this JSON data, do
//
//     final landResponseModel = landResponseModelFromJson(jsonString);

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
    this.polygon,
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
    this.latitude,
    this.saleData,
    this.longitude,
  });

  String? id;
  String? city;
  String? area;
  List<Polygon>? polygon;
  String? parcelId;
  String? wardNo;
  String? district;
  String? address;
  String? surveyNo;
  String? province;
  String? landPrice;
  String? isVerified;
  OwnerUserId? ownerUserId;
  List<dynamic>? ownerHistory;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? latitude;
  String? longitude;
  String? saleData;

  factory LandResult.fromJson(Map<String, dynamic> json) => LandResult(
        id: json["_id"],
        city: json["city"],
        area: json["area"],
        saleData: json["saleData"],
        polygon: json["polygon"] == null
            ? []
            : List<Polygon>.from(
                json["polygon"]!.map((x) => Polygon.fromJson(x))),
        parcelId: json["parcelId"],
        wardNo: json["wardNo"],
        district: json["district"],
        address: json["address"],
        surveyNo: json["surveyNo"],
        province: json["province"],
        landPrice: json["landPrice"],
        isVerified: json["isVerified"],
        ownerUserId: json["ownerUserId"] == null
            ? null
            : OwnerUserId.fromJson(json["ownerUserId"]),
        ownerHistory: json["ownerHistory"] == null
            ? []
            : List<dynamic>.from(json["ownerHistory"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "city": city,
        "area": area,
        "polygon": polygon == null
            ? []
            : List<dynamic>.from(polygon!.map((x) => x.toJson())),
        "parcelId": parcelId,
        "wardNo": wardNo,
        "district": district,
        "address": address,
        "saleData": saleData,
        "surveyNo": surveyNo,
        "province": province,
        "landPrice": landPrice,
        "isVerified": isVerified,
        "ownerUserId": ownerUserId?.toJson(),
        "ownerHistory": ownerHistory == null
            ? []
            : List<dynamic>.from(ownerHistory!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class OwnerUserId {
  OwnerUserId({
    this.imageFile,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.address,
    this.phoneNumber,
    this.isVerified,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  ImageFile? imageFile;
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? address;
  String? phoneNumber;
  String? isVerified;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory OwnerUserId.fromJson(Map<String, dynamic> json) => OwnerUserId(
        imageFile: json["imageFile"] == null
            ? null
            : ImageFile.fromJson(json["imageFile"]),
        id: json["_id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        isVerified: json["isVerified"],
        name: json["name"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "imageFile": imageFile?.toJson(),
        "_id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "phoneNumber": phoneNumber,
        "isVerified": isVerified,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class ImageFile {
  ImageFile({
    this.imageUrl,
    this.imagePublicId,
  });

  String? imageUrl;
  String? imagePublicId;

  factory ImageFile.fromJson(Map<String, dynamic> json) => ImageFile(
        imageUrl: json["imageUrl"],
        imagePublicId: json["imagePublicId"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "imagePublicId": imagePublicId,
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
