
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    Key? key,
    required this.controller,
    required this.lable,
    this.obscure = false,
    this.textInputType = TextInputType.text,
    required this.hintText,
    required this.hasIcon,
    this.icon = Icons.visibility,
    required this.onChanged,
    this.prefxIon = Icons.phone,
    this.prefixText = '',
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscure;
  final String lable;
  final TextInputType textInputType;
  final String hintText;
  final bool hasIcon;
  final IconData icon;
  final IconData prefxIon;
  final Function(String value) onChanged;
  final String prefixText;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  bool _visibility = true;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      // expands: true,
      // minLines: null,
      // maxLines: null,
      keyboardType: widget.textInputType ,
      focusNode: _focusNodes[0],
      controller: widget.controller,
      onChanged: widget.onChanged,
      showCursor: true,
      obscureText: widget.obscure,
      // obscuringCharacter: '*',

      decoration: InputDecoration(

        contentPadding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          maxHeight: 60,
          maxWidth: 300,
        ),

        prefixIcon: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('${widget.prefixText}',style: const TextStyle(color: Colors.grey),),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        enabledBorder: getBorder(),
        suffixIcon: widget.hasIcon
            ? IconButton(
                splashColor: Colors.transparent,
                color: _focusNodes[0].hasFocus
                    ? const Color(0xff636363)
                    : const Color(0xffB0B0B0),
                onPressed: () {
                  setState(() {
                    _visibility ? _visibility = false : _visibility = true;
                    _showPassword
                        ? _showPassword = false
                        : _showPassword = true;
                  });
                },
                icon: _visibility
                    ? Icon(widget.icon)
                    : const Icon(Icons.visibility_off),
              )
            : null,

        focusedBorder: getBorder(borderColor: Colors.indigo),
      ),
    );
  }

  bool checkIcon() {
    if (widget.hasIcon) {
      return true;
    } else {
      return false;
    }
  }

  bool showPassword() {
    if(_showPassword) {
      return false;
    } else {
      return true;
    }
  }

// bool check....
  OutlineInputBorder getBorder({Color borderColor = Colors.blueGrey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      gapPadding: 10,
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );
  }
}
