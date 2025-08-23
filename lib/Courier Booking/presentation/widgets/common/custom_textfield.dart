import 'package:courier_booking/Courier%20Booking/presentation/widgets/common/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../../theme/appColors.dart';

class LabelCustomTextField extends StatefulWidget {
  const LabelCustomTextField({
    super.key,
    required this.hintText,
    this.hintstyle,
    this.onPressed,
    this.onchanged,
    this.onFieldSubmit,
    this.passwordfield,
    this.showSuffixicon,
    this.controller,
    this.inputFormatters,
    this.suffix,
    this.validator,
    this.inputType,
    this.lines,
    this.onTap,
    this.readOnly,
    this.prefix,
    this.label,
    this.labelText,
    this.enable,
    this.autofillHints,
    this.autovalidateMode,
    required this.textFieldLabel,
    this.textInputAction,
    this.textFieldLabelstyle,
    this.isRemoveVerticalPadding,
    this.padding,
    this.isOptional = true,
    this.textCapitalization,
    this.onSaved,
  });

  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintstyle;
  final String? labelText;
  final bool? showSuffixicon;
  final bool? enable;
  final Function? onPressed;
  final Function? onTap;
  final Function? onchanged;
  final Function? onFieldSubmit;
  final bool? passwordfield;
  final Widget? suffix;
  final Function(String)? validator;
  final TextInputType? inputType;
  final int? lines;
  final Widget? prefix;
  final bool? readOnly;
  final Widget? label;
  final void Function(String?)? onSaved;

  final TextStyle? textFieldLabelstyle;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final String textFieldLabel;
  final TextInputAction? textInputAction;
  final bool? isRemoveVerticalPadding;
  final EdgeInsetsGeometry? padding;
  final bool? isOptional;
  final TextCapitalization? textCapitalization;

  @override
  State<LabelCustomTextField> createState() => _LabelCustomTextField();
}

class _LabelCustomTextField extends State<LabelCustomTextField> {
  bool showpassword = true;
  late bool showPrefixIcon;
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    showPrefixIcon = widget.showSuffixicon ?? false;
    _focusNode.addListener(_handleFocusChange);
    super.initState();
  }

  void _handleFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.textFieldLabel,
                style: GoogleFonts.poppins(
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              5.width,
              widget.isOptional == false
                  ? SizedBox.shrink()
                  : Text(
                      "*",
                      style: GoogleFonts.poppins(
                        color: AppColors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ],
          ),
          2.height,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.ogbackgroundcolor.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            width: w,
            child: TextFormField(
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              readOnly: widget.readOnly ?? false,
              autovalidateMode: widget.autovalidateMode,
              autofillHints: widget.autofillHints,
              inputFormatters: widget.inputFormatters,
              onTap: widget.onTap != null
                  ? () {
                      widget.onTap!();
                    }
                  : null,
              onChanged: (value) {
                if (widget.onchanged != null) {
                  widget.onchanged!(value);
                }
              },
              controller: widget.controller,
              validator: widget.validator == null
                  ? null
                  : (val) => widget.validator!(val ?? ""),
              obscureText: widget.passwordfield == true ? showpassword : false,
              keyboardType: widget.inputType ?? TextInputType.text,
              maxLines: widget.passwordfield == true ? 1 : widget.lines,
              onSaved: widget.onSaved,
              decoration: InputDecoration(
                filled: true,
                label: widget.label,
                labelText: widget.labelText,
                labelStyle: const TextStyle(),
                fillColor: AppColors.white,
                prefixIcon: showPrefixIcon ? widget.prefix : null,
                suffixIcon: widget.passwordfield == true
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                        icon: showpassword
                            ? Icon(
                                Ionicons.eye_off,
                                size: 20,
                                color: Theme.of(context).primaryColor,
                              )
                            : Icon(
                                Icons.remove_red_eye,
                                color: Theme.of(context).primaryColor,
                              ),
                      )
                    : widget.suffix,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 0.3),
                ),
                hintText: widget.hintText,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.3,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 0.3),
                ),
                disabledBorder: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(15),
                hintStyle:
                    widget.hintstyle ?? const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
