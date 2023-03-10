import 'dart:convert';

import '../land_response_model.dart';

IndividualLandSaleResponseModel individualLandSaleResponseModelFromJson(
        String str) =>
    IndividualLandSaleResponseModel.fromJson(json.decode(str));

String individualLandSaleResponseModelToJson(
        IndividualLandSaleResponseModel data) =>
    json.encode(data.toJson());

class IndividualLandSaleResponseModel {
  IndividualLandSaleResponseModel({
    this.data,
  });

  Data? data;

  factory IndividualLandSaleResponseModel.fromJson(Map<String, dynamic> json) =>
      IndividualLandSaleResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.landSaleData,
  });

  IndividualLandSaleData? landSaleData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        landSaleData: json["landSaleData"] == null
            ? null
            : IndividualLandSaleData.fromJson(json["landSaleData"]),
      );

  Map<String, dynamic> toJson() => {
        "landSaleData": landSaleData?.toJson(),
      };
}

class IndividualLandSaleData {
  IndividualLandSaleData({
    this.id,
    this.landId,
    this.parcelId,
    this.ownerUserId,
    this.saleData,
    this.requestedUserId,
    this.rejectedUserId,
    this.v,
    this.approvedUserId,
    this.prevOwnerUserId,
  });

  String? id;
  LandId? landId;
  String? parcelId;
  UserId? ownerUserId;
  String? saleData;
  UserId? approvedUserId;
  List<UserId>? requestedUserId;
  List<UserId>? rejectedUserId;
  UserId? prevOwnerUserId;
  int? v;

  factory IndividualLandSaleData.fromJson(Map<String, dynamic> json) =>
      IndividualLandSaleData(
        id: json["_id"],
        landId: json["landId"] == null ? null : LandId.fromJson(json["landId"]),
        parcelId: json["parcelId"],
        ownerUserId: json["ownerUserId"] == null
            ? null
            : UserId.fromJson(json["ownerUserId"]),
        approvedUserId: json["approvedUserId"] == null
            ? null
            : UserId.fromJson(json["approvedUserId"]),
        saleData: json["saleData"],
        requestedUserId: json["requestedUserId"] == null
            ? []
            : List<UserId>.from(
                json["requestedUserId"]!.map((x) => UserId.fromJson(x))),
        rejectedUserId: json["rejectedUserId"] == null
            ? []
            : List<UserId>.from(
                json["rejectedUserId"]!.map((x) => UserId.fromJson(x))),
        v: json["__v"],
        prevOwnerUserId: json["prevOwnerUserId"] == null
            ? null
            : UserId.fromJson(json["prevOwnerUserId"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "landId": landId?.toJson(),
        "parcelId": parcelId,
        "ownerUserId": ownerUserId?.toJson(),
        "approvedUserId": approvedUserId?.toJson(),
        "saleData": saleData,
        "requestedUserId": requestedUserId == null
            ? []
            : List<UserId>.from(requestedUserId!.map((x) => x.toJson())),
        "rejectedUserId": rejectedUserId == null
            ? []
            : List<UserId>.from(rejectedUserId!.map((x) => x)),
        "__v": v,
      };
}

class LandId {
  LandId({
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
    this.saleData,
    this.polygon,
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
  String? ownerUserId;
  List<dynamic>? ownerHistory;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? latitude;
  String? longitude;
  String? saleData;

  factory LandId.fromJson(Map<String, dynamic> json) => LandId(
        id: json["_id"],
        city: json["city"],
        area: json["area"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        parcelId: json["parcelId"],
        wardNo: json["wardNo"],
        district: json["district"],
        polygon: json["polygon"] == null
            ? []
            : List<Polygon>.from(
                json["polygon"]!.map((x) => Polygon.fromJson(x))),
        address: json["address"],
        surveyNo: json["surveyNo"],
        province: json["province"],
        landPrice: json["landPrice"],
        isVerified: json["isVerified"],
        ownerUserId: json["ownerUserId"],
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
        saleData: json["saleData"],
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
        "polygon": polygon == null
            ? []
            : List<dynamic>.from(polygon!.map((x) => x.toJson())),
        "ownerUserId": ownerUserId,
        "ownerHistory": ownerHistory == null
            ? []
            : List<dynamic>.from(ownerHistory!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "saleData": saleData,
      };
}

class UserId {
  UserId({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.address,
    this.phoneNumber,
    this.isVerified,
    this.ownedLand,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.frontCitizenshipFile,
    this.imageFile,
    this.backCitizenshipFile,
    this.nameTg,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? address;
  String? phoneNumber;
  String? isVerified;
  List<String>? ownedLand;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  FrontCitizenshipFile? frontCitizenshipFile;
  ImageFile? imageFile;
  BackCitizenshipFile? backCitizenshipFile;
  List<String>? nameTg;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        isVerified: json["isVerified"],
        ownedLand: json["ownedLand"] == null
            ? []
            : List<String>.from(json["ownedLand"]!.map((x) => x)),
        name: json["name"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        frontCitizenshipFile: json["frontCitizenshipFile"] == null
            ? null
            : FrontCitizenshipFile.fromJson(json["frontCitizenshipFile"]),
        imageFile: json["imageFile"] == null
            ? null
            : ImageFile.fromJson(json["imageFile"]),
        backCitizenshipFile: json["backCitizenshipFile"] == null
            ? null
            : BackCitizenshipFile.fromJson(json["backCitizenshipFile"]),
        nameTg: json["name_tg"] == null
            ? []
            : List<String>.from(json["name_tg"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "phoneNumber": phoneNumber,
        "isVerified": isVerified,
        "ownedLand": ownedLand == null
            ? []
            : List<dynamic>.from(ownedLand!.map((x) => x)),
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "frontCitizenshipFile": frontCitizenshipFile?.toJson(),
        "imageFile": imageFile?.toJson(),
        "backCitizenshipFile": backCitizenshipFile?.toJson(),
        "name_tg":
            nameTg == null ? [] : List<dynamic>.from(nameTg!.map((x) => x)),
      };
}

class BackCitizenshipFile {
  BackCitizenshipFile({
    this.backCitizenshipImage,
    this.backCitizenshipPublicId,
  });

  String? backCitizenshipImage;
  String? backCitizenshipPublicId;

  factory BackCitizenshipFile.fromJson(Map<String, dynamic> json) =>
      BackCitizenshipFile(
        backCitizenshipImage: json["backCitizenshipImage"],
        backCitizenshipPublicId: json["backCitizenshipPublicId"],
      );

  Map<String, dynamic> toJson() => {
        "backCitizenshipImage": backCitizenshipImage,
        "backCitizenshipPublicId": backCitizenshipPublicId,
      };
}

class FrontCitizenshipFile {
  FrontCitizenshipFile({
    this.frontCitizenshipImage,
    this.frontCitizenshipPublicId,
  });

  String? frontCitizenshipImage;
  String? frontCitizenshipPublicId;

  factory FrontCitizenshipFile.fromJson(Map<String, dynamic> json) =>
      FrontCitizenshipFile(
        frontCitizenshipImage: json["frontCitizenshipImage"],
        frontCitizenshipPublicId: json["frontCitizenshipPublicId"],
      );

  Map<String, dynamic> toJson() => {
        "frontCitizenshipImage": frontCitizenshipImage,
        "frontCitizenshipPublicId": frontCitizenshipPublicId,
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
