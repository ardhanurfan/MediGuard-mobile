import 'package:flutter/material.dart';
import 'package:mediguard/shared/theme.dart';

import 'custom_button.dart';
import 'custom_form_field.dart';

class AddReportPopUp extends StatelessWidget {
  final Function() onAdd;
  final TextEditingController controller;
  final bool isLoading;
  const AddReportPopUp(
      {super.key,
      required this.onAdd,
      required this.controller,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        actions: [
          Visibility(
            visible: !isLoading,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancle',
                style: disableText,
              ),
            ),
          ),
          Visibility(
            visible: !isLoading,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(secondaryColor),
              ),
              onPressed: onAdd,
              child: Text(
                'Save',
                style: whiteText,
              ),
            ),
          )
        ],
        title: Text(
          "Upload Your Report",
          style: primaryText.copyWith(fontSize: 16, fontWeight: bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFormField(
              hintText: 'Input your needs name',
              label: 'Needs Name',
              validator: 'Please input needs name',
              textController: controller,
            ),
            const SizedBox(height: 12),
            CustomFormField(
              hintText: 'Input price',
              label: 'Price (Rp)',
              validator: 'Please input price',
              textController: controller,
            ),
            CustomButton(
              marginTop: 12,
              buttonColor: primaryColor,
              buttonText: "Upload Evidence",
              onPressed: () {},
              textStyle: whiteText,
              icon: Icons.file_upload_outlined,
            ),
          ],
        ));
  }
}
