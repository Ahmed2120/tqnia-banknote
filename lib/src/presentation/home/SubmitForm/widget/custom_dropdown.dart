import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';


class CustomDropDown extends StatelessWidget {

  CustomDropDown(
      {required this.list,
        required this.onChange,
        this.item,
        this.hintText,
        Key? key}) :
        super(key: key);

  List<int> list; Function onChange;
  int ? item; String? hintText;

  @override
  Widget build(BuildContext context) {
    return  DropdownSearch<int>(
      popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
        showSearchBox: true
      ),
      items: list,
      // itemAsString: (CustomModel customModel) => customModel.Name,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            suffixIconColor: const Color(0xFF00B0BD),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText!,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(15))
        ),
      ),
      onChanged:(value)=> onChange(value),
      selectedItem: item,
    );
  }
}
