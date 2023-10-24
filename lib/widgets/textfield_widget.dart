import 'package:flutter/material.dart';

class Mytextfield extends StatefulWidget {
  Mytextfield(
      {Key? key,
      required this.hintText,
      required this.focusnode,
      this.nextFocus,
      required TextEditingController controller})
      : controller = controller,
        super(key: key);

  final TextEditingController controller;
  final FocusNode? nextFocus;
  final FocusNode focusnode;
  final String hintText;
  @override
  State<Mytextfield> createState() => _MytextfieldState();
}

class _MytextfieldState extends State<Mytextfield> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        focusNode: widget.focusnode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
        textInputAction: widget.nextFocus != null
            ? TextInputAction.next
            : TextInputAction.done,
        onSubmitted: (_) {
          if (widget.nextFocus != null) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          } else {
            widget.focusnode.unfocus();
          }
        },
      ),
    );
  }
}
