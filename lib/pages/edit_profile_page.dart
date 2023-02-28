import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gis_flutter_frontend/core/development/console.dart';
import 'package:gis_flutter_frontend/providers/user_provider.dart';
import 'package:gis_flutter_frontend/utils/validation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../core/config/regex_config.dart';
import '../core/dimensions/dimensions.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  XFile? pickedImage;
  Uint8List? memoryImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<UserProvider>(
        builder: (context, _, child) => Form(
          key: _.editProfileFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.ourText("FirstName"),
              vSizedBox1,
              CustomTextFormField(
                fullNameString: true,
                hintText: "FirstName",
                controller: _.editFirstNameController,
                validator: (val) => val.toString().isEmptyData()
                    ? "Cannot be empty"
                    : !RegexConfig.textRegex.hasMatch(val)
                        ? "Name not valid"
                        : null,
                textInputAction: TextInputAction.next,
              ),
              vSizedBox2,
              CustomText.ourText("LastName"),
              vSizedBox1,
              CustomTextFormField(
                fullNameString: true,
                hintText: "LastName",
                controller: _.editLastNameController,
                validator: (val) => val.toString().isEmptyData()
                    ? "Cannot be empty"
                    : !RegexConfig.textRegex.hasMatch(val)
                        ? "Name not valid"
                        : null,
                textInputAction: TextInputAction.next,
              ),
              vSizedBox2,
              CustomText.ourText("Address"),
              vSizedBox1,
              CustomTextFormField(
                fullNameString: true,
                hintText: "Address",
                controller: _.editAddressController,
                validator: (val) => val.toString().isEmptyData() ? "Cannot be empty" : null,
                textInputAction: TextInputAction.next,
              ),
              vSizedBox2,
              CustomText.ourText("Phone Number"),
              vSizedBox1,
              CustomTextFormField(
                fullNameString: true,
                hintText: "Phone Number",
                controller: _.editPhoneNumberController,
                onlyNumber: true,
                textInputType: TextInputType.number,
                validator: (val) => val.toString().isEmptyData()
                    ? "Cannot be empty"
                    : !RegexConfig.numberRegex.hasMatch(val)
                        ? "Phone number not valid"
                        : null,
                textInputAction: TextInputAction.next,
              ),
              vSizedBox2,
              CustomText.ourText("CitizenShip No"),
              vSizedBox1,
              CustomTextFormField(
                fullNameString: true,
                hintText: "CitizenShip No",
                controller: _.editCitizenshipNoController,
                validator: (val) => val.toString().isEmptyData() ? "Cannot be empty" : null,
                textInputAction: TextInputAction.next,
              ),
              vSizedBox2,
              CustomButton.elevatedButton(
                "upload image",
                () async {
                  pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                  logger(pickedImage?.path);
                  // memoryImage = await pickedImage?.readAsBytes();
                  setState(() {});
                  // var imageData = await ImagePickerWeb.getImageAsWidget();
                  // logger(imageData?.image);
                  // if (imageData != null) {
                  _.updateUserImage(context: context, uint8File: memoryImage, file: pickedImage);
                  // }
                },
                borderRadius: 16,
              ),
              memoryImage != null ? Image.memory(memoryImage!) : Container(),
              vSizedBox3,
              CustomButton.elevatedButton(
                "Save Changes",
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
