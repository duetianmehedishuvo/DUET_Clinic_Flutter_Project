import 'package:duet_clinic/services/testProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Color? fillColor;
  final int? maxLines;
  final bool? isPassword;
  final bool? isCountryPicker;
  final bool? isShowBorder;
  final bool? isIcon;
  final bool? isShowSuffixIcon;
  final bool? isShowPrefixIcon;
  final VoidCallback? onTap;
  final VoidCallback? onChanged;
  final VoidCallback? onSuffixTap;
  final IconData? suffixIconUrl;
  final String? prefixIconUrl;
  final bool? isSearch;
  final VoidCallback? onSubmit;
  final bool? isEnabled;
  final TextCapitalization? capitalization;
  final bool isDoctorSearch;

  const CustomTextField(
      {this.hintText = 'Write something...',
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onSuffixTap,
      this.fillColor,
      this.onSubmit,
      this.onChanged,
      this.capitalization = TextCapitalization.none,
      this.isCountryPicker = false,
      this.isShowBorder = false,
      this.isShowSuffixIcon = false,
      this.isShowPrefixIcon = false,
      this.onTap,
      this.isIcon = false,
      this.isPassword = false,
      this.suffixIconUrl,
      this.prefixIconUrl,
      this.isSearch = false,
      this.isDoctorSearch = false,
      Key? key})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style:
          Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 18),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      //cursorColor: getPrimaryColor(context),
      textCapitalization: widget.capitalization!,
      enabled: widget.isEnabled,
      autofocus: false,
      //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
      obscureText: widget.isPassword! ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone
          ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))]
          : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              style: widget.isShowBorder! ? BorderStyle.solid : BorderStyle.none,
              width: widget.isShowBorder! ? 2 : 0,
              color: widget.isShowBorder! ? Colors.teal : Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              style: widget.isShowBorder! ? BorderStyle.solid : BorderStyle.none,
              width: widget.isShowBorder! ? 2 : 0,
              color: widget.isShowBorder! ? Colors.teal : Colors.white),
        ),
        isDense: true,
        hintText: widget.hintText,
        fillColor: widget.fillColor ?? Colors.white,
        hintStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16, color: Colors.grey),
        filled: true,
        prefixIcon: widget.isShowPrefixIcon!
            ? Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Image.asset(widget.prefixIconUrl!),
              )
            : const SizedBox.shrink(),
        prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
        suffixIcon: widget.isShowSuffixIcon!
            ? widget.isPassword!
                ? IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle)
                : widget.isIcon!
                    ? IconButton(
                        onPressed: widget.onSuffixTap,
                        icon: Icon(widget.suffixIconUrl, color: Colors.teal, size: 30),
                      )
                    : null
            : null,
      ),
      onTap: widget.onTap,
      // onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) :
      // widget.onSubmit!(text),
      onChanged: (value) {
        if (widget.isDoctorSearch) {
          Provider.of<TestProvider>(context, listen: false).searchAllShortDoctors(value);
        }
      },
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
