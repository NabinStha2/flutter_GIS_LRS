import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/model/land/land_request_model.dart';
import 'package:gis_flutter_frontend/services/base_client_controller.dart';
import 'package:gis_flutter_frontend/utils/custom_toasts.dart';

import '../core/app/enums.dart';
import '../core/config/api_config.dart';
import '../core/development/console.dart';
import '../core/routing/route_navigation.dart';
import '../model/land_response_model.dart';
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
  }) async {
    try {
      isLoading = true;
      paginatedOwnedLandResultPageNumber = landRequestModel?.page ?? 1;
      if (landRequestModel?.page == 1) {
        paginatedOwnedLandResultPageNumber = 1;
        paginatedOwnedLandResult?.clear();
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
      isLoading = false;
      notifyListeners();
    } on AppException catch (err) {
      isLoading = false;
      getLandMessage = err.message.toString();
      notifyListeners();
    } catch (e) {
      isLoading = false;
      getLandMessage = e.toString();
      notifyListeners();
      logger(e.toString(), loggerType: LoggerType.error);
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
      notifyListeners();
    } on AppException catch (err) {
      isLoading = false;
      getLandMessage = err.message.toString();
      notifyListeners();
    } catch (e) {
      isLoading = false;
      getLandMessage = e.toString();
      notifyListeners();
      logger(e.toString(), loggerType: LoggerType.error);
    }
  }
}
