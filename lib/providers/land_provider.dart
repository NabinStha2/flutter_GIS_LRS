// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/model/land/land_request_model.dart';
import 'package:gis_flutter_frontend/services/base_client_controller.dart';
import 'package:gis_flutter_frontend/utils/custom_toasts.dart';
import 'package:latlong2/latlong.dart';

import '../core/app/enums.dart';
import '../core/config/api_config.dart';
import '../core/development/console.dart';
import '../core/routing/route_navigation.dart';
import '../model/land/individual_land_response_model.dart';
import '../model/land/individual_land_sale_response_model.dart';
import '../model/land/land_sale_response_model.dart';
import '../model/land_response_model.dart';
import '../screens/map_page.dart';
import '../services/api_exceptions.dart';
import '../services/base_client.dart';
import '../utils/app_shared_preferences.dart';
import '../utils/get_query.dart';
import '../widgets/custom_dialogs.dart';

class LandProvider extends ChangeNotifier with BaseController {
  bool isLoading = false;

  GlobalKey<FormState> addLandFormKey = GlobalKey<FormState>();
  List<TextEditingController> textEditingControllers =
      <TextEditingController>[];
  TextEditingController cityController = TextEditingController();
  TextEditingController wardNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController parcelIdController = TextEditingController();
  TextEditingController landPriceController = TextEditingController();
  TextEditingController surveyNoController = TextEditingController();

  TextEditingController searchLandController = TextEditingController();

  TextEditingController filterCityLandController = TextEditingController();
  TextEditingController filterDistrictLandController = TextEditingController();
  TextEditingController filterProvinceLandController = TextEditingController();

  IndividualLandData? individualLandResult = IndividualLandData();
  String? getIndividualLandMessage;

  List<LandResult>? paginatedOwnedLandResult = <LandResult>[];
  int paginatedOwnedLandResultPageNumber = 0;
  int paginatedOwnedLandResultCount = 0;
  int paginatedOwnedLandResultTotalPages = 0;
  String? getLandMessage;

  List<LandResult>? paginatedAllSearchLandResult = <LandResult>[];
  int paginatedAllSearchLandResultPageNumber = 0;
  int paginatedAllSearchLandResultCount = 0;
  int paginatedAllSearchLandResultTotalPages = 0;
  String? getAllSearchLandMessage;

  List<LandSaleResult> paginatedSaleLandResult = <LandSaleResult>[];
  int paginatedSaleLandResultPageNumber = 0;
  int paginatedSaleLandResultCount = 0;
  int paginatedSaleLandResultTotalPages = 0;
  String? getSaleLandMessage;

  List<LandSaleResult> paginatedOwnedSaleLandResult = <LandSaleResult>[];
  int paginatedOwnedSaleLandResultPageNumber = 0;
  int paginatedOwnedSaleLandResultCount = 0;
  int paginatedOwnedSaleLandResultTotalPages = 0;
  String? getOwnedSaleLandMessage;

  IndividualLandSaleData? individualSaleLandResult = IndividualLandSaleData();
  String? getIndividualSaleLandMessage;

  addLand(
      {required BuildContext context,
      required List<Map<String, dynamic>> polygonData}) async {
    try {
      isLoading = true;
      CustomDialogs.fullLoadingDialog(
          data: "Adding Land, Please wait...", context: context);
      var userId = AppSharedPreferences.getUserId;
      consolelog(userId);
      var response = await BaseClient()
          .post(
            ApiConfig.baseUrl,
            "${ApiConfig.landUrl}/$userId${ApiConfig.addLandUrl}",
            {
              "city": cityController.text.trim(),
              "wardNo": wardNoController.text.trim(),
              "address": addressController.text.trim(),
              "area": areaController.text.trim(),
              "province": provinceController.text.trim(),
              "district": districtController.text.trim(),
              "parcelId": parcelIdController.text.trim(),
              "landPrice": landPriceController.text.trim(),
              "surveyNo": surveyNoController.text.trim(),
              "polygon": polygonData,
            },
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;
      // var decodedJson = landResponseModelFromJson(response);
      // landData = decodedJson.data?.landData ?? LandData();
      isLoading = false;
      hideLoading(context);
      back(context);
      successToast(msg: "Land added successfully.");
      getOwnedLands(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
      notifyListeners();
    } catch (e) {
      logger(e.toString(), loggerType: LoggerType.error);
    }
  }

  clearPaginatedOwnedLandValue() {
    paginatedOwnedLandResult?.clear();
    paginatedOwnedLandResultCount = 0;
    paginatedOwnedLandResultPageNumber = 0;
    paginatedOwnedLandResultTotalPages = 0;
  }

  getOwnedLands({
    required BuildContext context,
    LandRequestModel? landRequestModel,
    bool? isFromMap = false,
    LatLng? latlngData,
  }) async {
    try {
      isLoading = true;

      paginatedOwnedLandResultPageNumber = landRequestModel?.page ?? 1;
      if (landRequestModel?.page == 1) {
        paginatedOwnedLandResultPageNumber = 1;
        paginatedOwnedLandResult?.clear();
        notifyListeners();
      }
      var response = await BaseClient()
          .get(
            ApiConfig.baseUrl,
            "${ApiConfig.landUrl}${ApiConfig.userLandsUrl}${getQuery(landRequestModel)}",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;
      var decodedJson = landResponseModelFromJson(response);
      paginatedOwnedLandResultCount = decodedJson.data?.landData?.count ?? 0;
      paginatedOwnedLandResultPageNumber =
          decodedJson.data?.landData?.currentPageNumber ?? 0;
      paginatedOwnedLandResultTotalPages =
          decodedJson.data?.landData?.totalPages ?? 0;
      paginatedOwnedLandResult
          ?.addAll(decodedJson.data?.landData?.results ?? []);

      if (isFromMap ?? false) {
        var latlngTempList = <LatLng>[];
        latlngList.value.clear();
        if (paginatedOwnedLandResult?.isNotEmpty ?? false) {
          for (LandResult e in paginatedOwnedLandResult!) {
            // consolelog(e.polygon);
            e.polygon?.forEach((data) {
              // consolelog(e.latitude);
              latlngTempList.add(LatLng(
                  double.parse(data.latitude!), double.parse(data.longitude!)));
            });
            // logger(latlngTempList.toString());
            latlngList.value
                .add({"polygonData": latlngTempList, "parcelId": e.parcelId});
            // logger(latlngList.value.toString(), loggerType: LoggerType.success);
            latlngTempList = [];
          }
        }

        // logger(latlngList.value.toString(), loggerType: LoggerType.warning);
      }
      isLoading = false;
      getLandMessage = null;
      notifyListeners();
    } on AppException catch (err) {
      logger(err.toString(), loggerType: LoggerType.error);
      isLoading = false;
      getLandMessage = err.message.toString();
      notifyListeners();
    } catch (e) {
      logger(e.toString(), loggerType: LoggerType.error);
      isLoading = false;
      getLandMessage = e.toString();
      notifyListeners();
    }
  }

  clearPaginatedAllSearchLandValue() {
    paginatedAllSearchLandResult?.clear();
    paginatedAllSearchLandResultCount = 0;
    paginatedAllSearchLandResultPageNumber = 0;
    paginatedAllSearchLandResultTotalPages = 0;
  }

  getAllSearchLands({
    required BuildContext context,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;
      paginatedAllSearchLandResultPageNumber = landRequestModel?.page ?? 1;
      if (landRequestModel?.page == 1) {
        paginatedAllSearchLandResultPageNumber = 1;
        paginatedAllSearchLandResult?.clear();
        notifyListeners();
      }
      var response = await BaseClient()
          .get(
            ApiConfig.baseUrl,
            "${ApiConfig.landUrl}${getQuery(landRequestModel, search: landRequestModel?.search)}",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;
      var decodedJson = landResponseModelFromJson(response);
      paginatedAllSearchLandResultCount =
          decodedJson.data?.landData?.count ?? 0;
      paginatedAllSearchLandResultPageNumber =
          decodedJson.data?.landData?.currentPageNumber ?? 0;
      paginatedAllSearchLandResultTotalPages =
          decodedJson.data?.landData?.totalPages ?? 0;
      paginatedAllSearchLandResult
          ?.addAll(decodedJson.data?.landData?.results ?? []);

      isLoading = false;
      getAllSearchLandMessage = null;
      notifyListeners();
    } on AppException catch (err) {
      isLoading = false;
      getAllSearchLandMessage = err.message.toString();
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      getAllSearchLandMessage = e.toString();
      notifyListeners();
      consolelog(e.toString());
    }
  }

  deleteLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;
      CustomDialogs.fullLoadingDialog(
          data: "Deleting Land, Please wait...", context: context);
      var response = await BaseClient()
          .delete(
            ApiConfig.baseUrl,
            "${ApiConfig.landUrl}/${landRequestModel?.landId}",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;
      var decodedJson = landResponseModelFromJson(response);
      isLoading = false;
      hideLoading(context);
      notifyListeners();
      getOwnedLands(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
    } on AppException catch (err) {
      logger(err.toString(), loggerType: LoggerType.error);
    } catch (e) {
      consolelog(e.toString());
    }
  }

  getIndividualLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await BaseClient()
          .get(
            ApiConfig.baseUrl,
            "${ApiConfig.landUrl}${ApiConfig.individualSaleLandsUrl}/${landRequestModel?.landId}",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;

      var decodedJson = individualLandResponseModelFromJson(response);
      individualLandResult = decodedJson.data?.landData ?? IndividualLandData();

      isLoading = false;
      getIndividualLandMessage = null;
      notifyListeners();
    } on AppException catch (err) {
      isLoading = false;
      getIndividualLandMessage = err.message.toString();
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      getIndividualLandMessage = e.toString();
      notifyListeners();
      consolelog(e.toString());
    }
  }

// LAND SALE ---------------------------------------

  addSaleLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;
      CustomDialogs.fullLoadingDialog(
          data: "Adding Land for sale, Please wait...", context: context);
      var userId = AppSharedPreferences.getUserId;
      consolelog(userId);
      var response = await BaseClient()
          .post(
            ApiConfig.baseUrl,
            "${ApiConfig.saleLandsUrl}/${landRequestModel?.landId}",
            {},
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;
      isLoading = false;
      hideLoading(context);
      successToast(msg: "Land for sale added successfully.");
      getIndividualLand(
          context: context,
          landRequestModel: LandRequestModel(
            landId: landRequestModel?.landId,
          ));
      notifyListeners();
    } catch (e) {
      logger(e.toString(), loggerType: LoggerType.error);
    }
  }

  clearPaginatedSaleLandValue() {
    paginatedSaleLandResult.clear();
    paginatedSaleLandResultCount = 0;
    paginatedSaleLandResultPageNumber = 0;
    paginatedSaleLandResultTotalPages = 0;
  }

  getSaleLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;
      paginatedSaleLandResultPageNumber = landRequestModel?.page ?? 1;
      if (landRequestModel?.page == 1) {
        paginatedSaleLandResultPageNumber = 1;
        paginatedSaleLandResult.clear();
        notifyListeners();
      }
      var response = await BaseClient()
          .get(
            ApiConfig.baseUrl,
            "${ApiConfig.saleLandsUrl}${getQuery(landRequestModel, search: landRequestModel?.search)}",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;

      var decodedJson = landSaleResponseModelFromJson(response);
      paginatedSaleLandResultCount = decodedJson.data?.landSaleData?.count ?? 0;
      paginatedSaleLandResultPageNumber =
          decodedJson.data?.landSaleData?.currentPageNumber ?? 0;
      paginatedSaleLandResultTotalPages =
          decodedJson.data?.landSaleData?.totalPages ?? 0;
      paginatedSaleLandResult
          .addAll(decodedJson.data?.landSaleData?.results ?? []);

      isLoading = false;
      getSaleLandMessage = null;

      notifyListeners();
    } on AppException catch (err) {
      isLoading = false;
      getSaleLandMessage = err.message.toString();
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      getSaleLandMessage = e.toString();
      notifyListeners();
      consolelog(e.toString());
    }
  }

  clearPaginatedOwnedSaleLandValue() {
    paginatedOwnedSaleLandResult.clear();
    paginatedOwnedSaleLandResultCount = 0;
    paginatedOwnedSaleLandResultPageNumber = 0;
    paginatedOwnedSaleLandResultTotalPages = 0;
  }

  getOwnedSaleLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;
      paginatedOwnedSaleLandResultPageNumber = landRequestModel?.page ?? 1;
      if (landRequestModel?.page == 1) {
        paginatedOwnedSaleLandResultPageNumber = 1;
        paginatedOwnedSaleLandResult.clear();
        notifyListeners();
      }
      var userId = AppSharedPreferences.getUserId;
      var response = await BaseClient()
          .get(
            ApiConfig.baseUrl,
            "${ApiConfig.saleLandsUrl}/$userId${getQuery(landRequestModel, search: landRequestModel?.search)}",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;

      var decodedJson = landSaleResponseModelFromJson(response);
      paginatedOwnedSaleLandResultCount =
          decodedJson.data?.landSaleData?.count ?? 0;
      paginatedOwnedSaleLandResultPageNumber =
          decodedJson.data?.landSaleData?.currentPageNumber ?? 0;
      paginatedOwnedSaleLandResultTotalPages =
          decodedJson.data?.landSaleData?.totalPages ?? 0;
      paginatedOwnedSaleLandResult
          .addAll(decodedJson.data?.landSaleData?.results ?? []);

      isLoading = false;
      getOwnedSaleLandMessage = null;

      notifyListeners();
    } on AppException catch (err) {
      isLoading = false;
      getOwnedSaleLandMessage = err.message.toString();
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      getOwnedSaleLandMessage = e.toString();
      notifyListeners();
      consolelog(e.toString());
    }
  }

  getIndividualSaleLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await BaseClient()
          .get(
            ApiConfig.baseUrl,
            "${ApiConfig.saleLandsUrl}${ApiConfig.individualSaleLandsUrl}/${landRequestModel?.landSaleId}",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;

      var decodedJson = individualLandSaleResponseModelFromJson(response);
      individualSaleLandResult =
          decodedJson.data?.landSaleData ?? IndividualLandSaleData();
      isLoading = false;
      getIndividualSaleLandMessage = null;
      notifyListeners();
    } on AppException catch (err) {
      isLoading = false;
      getIndividualSaleLandMessage = err.message.toString();
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      getIndividualSaleLandMessage = e.toString();
      notifyListeners();
      consolelog(e.toString());
    }
  }

  deleteSaleLand({
    required BuildContext context,
    bool? isFromLandSale = true,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;

      CustomDialogs.fullLoadingDialog(
          data: "Deleting Land Sale, Please wait...", context: context);
      var response = await BaseClient()
          .delete(
            ApiConfig.baseUrl,
            "${ApiConfig.saleLandsUrl}/${landRequestModel?.landSaleId}/${landRequestModel?.landId}",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;

      hideLoading(context);
      isLoading = false;
      notifyListeners();
      back(context);
      getOwnedSaleLand(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
      getSaleLand(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
    } on AppException catch (err) {
      isLoading = false;
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      consolelog(e.toString());
    }
  }

  requestToBuySaleLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;

      CustomDialogs.fullLoadingDialog(
          data: "Requesting to buy Land, Please wait...", context: context);
      var response = await BaseClient()
          .patch(
            ApiConfig.baseUrl,
            "${ApiConfig.saleLandsUrl}${ApiConfig.requestToBuySaleLandsUrl}/${landRequestModel?.landSaleId}",
            {},
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;

      hideLoading(context);
      isLoading = false;
      notifyListeners();
      getIndividualSaleLand(
        context: context,
        landRequestModel: LandRequestModel(
          landSaleId: landRequestModel?.landSaleId,
        ),
      );
      getOwnedSaleLand(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
      getSaleLand(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
    } on AppException catch (err) {
      isLoading = false;
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      consolelog(e.toString());
    }
  }

  acceptToBuySaleLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
    String? acceptedUserId,
  }) async {
    try {
      isLoading = true;

      CustomDialogs.fullLoadingDialog(
          data: "Accepting buy Land, Please wait...", context: context);
      var response = await BaseClient()
          .patch(
            ApiConfig.baseUrl,
            "${ApiConfig.saleLandsUrl}/${landRequestModel?.landSaleId}${ApiConfig.acceptToBuySaleLandsUrl}/$acceptedUserId",
            {},
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;

      hideLoading(context);
      isLoading = false;
      notifyListeners();
      getIndividualSaleLand(
        context: context,
        landRequestModel: LandRequestModel(
          landSaleId: landRequestModel?.landSaleId,
        ),
      );
      getOwnedSaleLand(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
      getSaleLand(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
    } on AppException catch (err) {
      isLoading = false;
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      consolelog(e.toString());
    }
  }

  rejectToBuySaleLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
    String? rejectedUserId,
  }) async {
    try {
      isLoading = true;

      CustomDialogs.fullLoadingDialog(
          data: "Rejecting buy Land, Please wait...", context: context);
      var response = await BaseClient()
          .patch(
            ApiConfig.baseUrl,
            "${ApiConfig.saleLandsUrl}/${landRequestModel?.landSaleId}${ApiConfig.rejectToBuySaleLandsUrl}/$rejectedUserId",
            {},
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;

      hideLoading(context);
      isLoading = false;
      notifyListeners();
      getIndividualSaleLand(
        context: context,
        landRequestModel: LandRequestModel(
          landSaleId: landRequestModel?.landSaleId,
        ),
      );
      getOwnedSaleLand(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
      getSaleLand(
        context: context,
        landRequestModel: LandRequestModel(page: 1),
      );
    } on AppException catch (err) {
      isLoading = false;
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      consolelog(e.toString());
    }
  }

  ownedRequestedSaleLand({
    required BuildContext context,
    LandRequestModel? landRequestModel,
  }) async {
    try {
      isLoading = true;

      paginatedOwnedSaleLandResultPageNumber = landRequestModel?.page ?? 1;
      if (landRequestModel?.page == 1) {
        paginatedOwnedSaleLandResultPageNumber = 1;
        paginatedOwnedSaleLandResult.clear();
        notifyListeners();
      }

      var userId = AppSharedPreferences.getUserId;
      var response = await BaseClient()
          .get(
            ApiConfig.baseUrl,
            "${ApiConfig.saleLandsUrl}${ApiConfig.ownedRequestedSaleLandsUrl}/$userId",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;

      var decodedJson = landSaleResponseModelFromJson(response);
      paginatedOwnedSaleLandResultCount =
          decodedJson.data?.landSaleData?.count ?? 0;
      paginatedOwnedSaleLandResultPageNumber =
          decodedJson.data?.landSaleData?.currentPageNumber ?? 0;
      paginatedOwnedSaleLandResultTotalPages =
          decodedJson.data?.landSaleData?.totalPages ?? 0;
      paginatedOwnedSaleLandResult
          .addAll(decodedJson.data?.landSaleData?.results ?? []);
      isLoading = false;
      getOwnedSaleLandMessage = null;

      notifyListeners();
    } on AppException catch (err) {
      isLoading = false;
      getOwnedSaleLandMessage = err.message.toString();
      logger(err.toString(), loggerType: LoggerType.error);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      getOwnedSaleLandMessage = e.toString();
      notifyListeners();
      consolelog(e.toString());
    }
  }
}
