import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/pages/map_page.dart';
import 'package:gis_flutter_frontend/widgets/custom_text.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/custom_text_form_field.dart';

ValueNotifier<int> textFormFieldLength = ValueNotifier<int>(3);

class AddPolygon extends StatefulWidget {
  const AddPolygon({super.key});

  @override
  State<AddPolygon> createState() => _AddPolygonState();
}

class _AddPolygonState extends State<AddPolygon> {
  GlobalKey<FormState> polygonFormKey = GlobalKey<FormState>();
  List<TextEditingController> textEditingControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();

    debugPrint("from init of add polygon :: ${textEditingControllers.length.toString()}");
    textFormFieldLength.value = 3;
    List.generate(3, (index) {
      TextEditingController textEditingController = TextEditingController();
      textEditingControllers.add(textEditingController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: polygonFormKey,
        child: ValueListenableBuilder(
          valueListenable: textFormFieldLength,
          builder: (context, val, _) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    textFormFieldLength.value++;
                    TextEditingController textEditingController = TextEditingController();
                    textEditingControllers.add(textEditingController);
                  },
                  child: CustomText.ourText(
                    "Add",
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                      children: List.generate(
                    textFormFieldLength.value,
                    (index) => CustomTextFormField(
                      autoFillHint: const ["51.5, -0.09", "53.3498, -6.2603", "48.8566, 2.3522"],
                      controller: textEditingControllers[index],
                      validator: (val) {
                        return val?.isEmpty ?? false ? "cannot be empty" : null;
                      },
                      hintText: "24.42 , 23.45",
                    ),
                  )),
                ),
                ElevatedButton(
                  onPressed: () {
                    var latlngTempList = <LatLng>[];
                    for (var e in textEditingControllers) {
                      latlngTempList.add(LatLng(double.parse(e.text.split(",")[0].trim()), double.parse(e.text.split(",")[1].trim())));
                    }
                    latlngList.value.add(latlngTempList);
                    debugPrint(latlngTempList.toString());
                    debugPrint(latlngList.value.toString());
                  },
                  child: CustomText.ourText(
                    "Add",
                    fontSize: 14,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
