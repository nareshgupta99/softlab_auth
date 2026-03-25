import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpFields extends StatelessWidget {
  final void Function(String) onChanged;
  final List<TextEditingController> controllers;
  final _focusNode;

  OtpFields({super.key, required this.onChanged, required this.controllers}) : _focusNode = List.generate(controllers.length, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _focusNode.length,
        (index) => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: OtpField(
            focusNode: _focusNode[index],
            first: controllers[index],
            onChanged: (value) {
              if (value.isEmpty && index > 0) {
                _focusNode[index - 1].requestFocus();
              } else if (value.isNotEmpty && index < _focusNode.length - 1) {
                _focusNode[index + 1].requestFocus();
              } else {
                _focusNode[index].unfocus();
              }
              onChanged(value);
            },
          ),
        ),
      ),
    );
  }
}

class OtpField extends StatelessWidget {
  final FocusNode focusNode;
  final void Function(String) onChanged;
  final TextEditingController first;
  const OtpField({super.key, required this.focusNode, required this.onChanged, required this.first});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: SizedBox(
        width: (size.width - 144) / 5,
        height: (size.width - 144) / 4,
        child: TextField(
          maxLength: 1,
          focusNode: focusNode,
          onChanged: onChanged,
          textAlign: TextAlign.center,
          controller: first,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            counterText: "",
            fillColor: Color(0xffe9e8e8),
            filled: true,
            border: UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
