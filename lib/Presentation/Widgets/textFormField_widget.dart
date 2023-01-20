import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';

class TextFormFieldWidget extends StatefulWidget {
  final hintText;
  final icon;
  final type;
  final textController;
  final validator;
  const TextFormFieldWidget(
      {super.key,
      @required this.hintText,
      @required this.icon,
      @required this.type,
      @required this.textController,
      @required this.validator});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isPasswordShow = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
      child: TextFormField(
        controller: widget.textController,
        minLines: (widget.type == TextInputType.multiline) ? 6 : 1,
        maxLines: (widget.type == TextInputType.multiline) ? 6 : 1,
        obscureText: (widget.type == TextInputType.visiblePassword &&
                isPasswordShow == false)
            ? true
            : false,
        keyboardType: widget.type,
        onFieldSubmitted: (value) => {},
        onChanged: (value) => {},
        validator: widget.validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: white,
          hintText: widget.hintText,
          prefixIcon: Icon(widget.icon, color: orange),
          suffixIcon: (widget.type == TextInputType.visiblePassword)
              ? IconButton(
                  icon: (isPasswordShow == true)
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isPasswordShow = !isPasswordShow;
                    });
                  })
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: orange,
            ),
          ),
        ),
      ),
    );
  }
}
