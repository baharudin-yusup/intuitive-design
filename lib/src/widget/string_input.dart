import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../function/constant.dart';

enum StringInputType {
  short,
  normal,
  long,
}

class StringInput extends StatelessWidget {
  final String title;
  final String hint;

  final String initialValue;

  final void Function(String) onChanged;
  final void Function(String) onSaved;

  final TextInputType keyboardType;
  final TextInputAction inputAction;

  final Function(String)? validator;
  final List<TextInputFormatter> inputFormatters;

  final StringInputType type;

  final bool obscureText;

  final EdgeInsets padding;
  final EdgeInsets margin;

  final StringInputStyle style;

  const StringInput({
    this.title = '',
    this.hint = '',
    required this.onChanged,
    void Function(String)? onSaved,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters = const [],
    this.type = StringInputType.normal,
    this.inputAction = TextInputAction.done,
    this.obscureText = false,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.initialValue = '',
    this.style = const StringInputStyle.neutral(),
    Key? key,
  })  : onSaved = onSaved ?? onChanged,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: title,
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          isDense: true,
        ),
        obscureText: obscureText,
        maxLines: type == StringInputType.long ? null : 1,
        keyboardType: keyboardType,
        textInputAction: inputAction,
        onChanged: onChanged,
        onSaved: (data) => onSaved(data ?? ''),
        textAlign: TextAlign.start,
        autocorrect: false,
        validator: validator as String? Function(String?)?,
        maxLength: type == StringInputType.short ? 30 : null,
        inputFormatters: inputFormatters,
      ),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     _buildTitle(context),
      //     _buildField(context),
      //   ],
      // ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (title.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: WidgetConstant.minorSpacing),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _buildField(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: title,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        isDense: true,
      ),
      obscureText: obscureText,
      maxLines: type == StringInputType.long ? null : 1,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      onChanged: onChanged,
      onSaved: (data) => onSaved(data ?? ''),
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyText1,
      autocorrect: false,
      validator: validator as String? Function(String?)?,
      maxLength: type == StringInputType.short ? 30 : null,
      inputFormatters: inputFormatters,
    );
  }
}

class StringInputStyle {
  final bool compact;

  StringInputStyle({this.compact = false});

  const StringInputStyle.neutral({this.compact = false});
}
