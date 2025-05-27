import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:get/get.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown(
      {super.key,
      required this.label,
      this.onChanged,
      this.items,
      required this.dropDownValue});
  final Widget label;
  final void Function(String?)? onChanged;
  final List<String>? items;
  final String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        color: borderColor.withOpacity(0.25),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                value: dropDownValue,
                isExpanded: true,
                underline: const SizedBox(),
                dropdownColor: blackColor,
                iconEnabledColor: whiteColor,
                iconDisabledColor: whiteColor,
                hint: label,
                borderRadius: BorderRadius.circular(5),
                items: items?.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        color: whiteColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              )),
        ),
      );
    });
  }
}
