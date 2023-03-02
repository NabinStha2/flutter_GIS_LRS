import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/services/base_client_controller.dart';
import 'package:gis_flutter_frontend/utils/custom_toasts.dart';

import '../core/app/enums.dart';
import '../core/config/api_config.dart';
import '../core/development/console.dart';
import '../core/routing/route_navigation.dart';
import '../model/land_response_model.dart';
import '../services/base_client.dart';
import '../utils/app_shared_preferences.dart';
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

  var landData = LandData();

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

  getLands({
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      var response = await BaseClient()
          .get(
            ApiConfig.baseUrl,
            "${ApiConfig.landUrl}/admin?page=1&limit=20",
            hasTokenHeader: true,
          )
          .catchError(handleError);
      if (response == null) return false;
      var decodedJson = landResponseModelFromJson(response);
      landData = decodedJson.data?.landData ?? LandData();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      logger(e.toString(), loggerType: LoggerType.error);
    }
  }
}
