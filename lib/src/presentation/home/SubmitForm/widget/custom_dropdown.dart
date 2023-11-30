import 'package:dropdown_search/dropdown_search.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';


class CustomDropDown extends StatelessWidget {

  CustomDropDown(
      {required this.list,
        required this.onChange,
        required this.validator,
        this.item,
        this.hintText,
        Key? key}) :
        super(key: key);

  List<int> list; Function onChange;
  int ? item; String? hintText;
  Validator validator;

  @override
  Widget build(BuildContext context) {
    return  DropdownSearch<int>(
      popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
        showSearchBox: true
      ),
      dropdownButtonProps: const DropdownButtonProps(
        color: Colors.white
      ),
      items: list,
      validator: validator,
      // itemAsString: (CustomModel customModel) => customModel.Name,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            suffixIconColor: Colors.black,
            filled: true,
            fillColor: Colors.white38,
            hintText: hintText!,
            hintStyle: const TextStyle(color: Colors.white),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
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
