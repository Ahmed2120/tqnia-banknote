import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFormField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isSearch;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? obscure;
  final bool? enabled;
  final bool hasConstraints;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? onChanged;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final Color? borderColor;
  final Color? fillColor;
  final bool filled;
  final bool readOnly;
  final bool above;
  final BorderRadius? borderRadius;
  final double? height;
  final TextEditingController? controller;
  final Function()? onTap;
  final TextDirection? textDirection;

  const InputFormField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.isSearch = false,
    this.textDirection,
    this.labelText,
    this.onTap,
    this.height,
    this.readOnly = false,
    this.above = false,
    this.hasConstraints = true,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.fillColor,
    this.maxLength,
    this.obscure,
    this.enabled,
    this.onSaved,
    this.onChanged,
    this.filled = false,
    this.minLines,
    this.maxLines,
    this.autofillHints,
    this.textInputAction,
    this.initialValue,
    this.borderColor,
    this.borderRadius,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height,
          child: TextFormField(
            textDirection: textDirection,
            onTap: onTap,
            controller: controller,
            enabled: enabled ?? true,
            obscureText: obscure ?? false,
            keyboardType: keyboardType,
            maxLength: maxLength,
            autofillHints: autofillHints,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            validator: validator,
            onSaved: onSaved,
            onChanged: onChanged,
            minLines: minLines,
            maxLines: maxLines ?? 1,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
            cursorColor: Theme.of(context).primaryColor,
            initialValue: initialValue,
            readOnly: readOnly,
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? Colors.white,
              hintText: hintText,
              labelText: above ? null : labelText,
              hintStyle: isSearch
                  ? Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14)
                  : null,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: hasConstraints ? 8.0 : 0.0),
                child: prefixIcon,
              ),
              prefixIconConstraints: hasConstraints
                  ? const BoxConstraints(maxWidth: 60, maxHeight: 60)
                  : null,
              suffixIcon: Padding(
                padding: EdgeInsets.all(isSearch ? 2 : 12),
                child: suffixIcon,
              ),
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
