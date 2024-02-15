import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ovrsr/utils/app_styles.dart';
import 'package:ovrsr/utils/snackbar_utils.dart';

class CustomTextField extends StatefulWidget {
  final int maxLength;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;

  const CustomTextField(
      {super.key,
      required this.maxLength,
      this.maxLines,
      required this.hintText,
      required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _fucosNode = FocusNode(); //If you tab it lets you go to the next imput

  @override
  void dispose() {
    _fucosNode.dispose(); //gets ride of it when we do not need it
    super.dispose();
  }

  void copyToClipboard(context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    SnackBarUtils.showSnackbar(context, Icons.content_copy, 'Coppied Text');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _fucosNode,
      onEditingComplete: () =>
          FocusScope.of(context).nextFocus(), //Grabs next focus
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      cursorColor: AppTheme.accent,
      style: AppTheme.inputStyle,
      decoration: InputDecoration(
        hintStyle: AppTheme.hintStyle,
        hintText: widget.hintText,
        suffixIcon: _copyButton(context),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.accent,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.meduim,
          ),
        ),
        counterStyle: AppTheme.counterStyle,
      ),
    );
  }

  IconButton _copyButton(BuildContext context) {
    return IconButton(
      onPressed: widget.controller.text.isNotEmpty
          ? () => copyToClipboard(context, widget.controller.text)
          : null,
      color: AppTheme.accent,
      disabledColor: AppTheme.meduim,
      splashRadius: 20,
      splashColor: AppTheme.accent,
      icon: const Icon(Icons.content_copy_rounded),
    );
  }
}
