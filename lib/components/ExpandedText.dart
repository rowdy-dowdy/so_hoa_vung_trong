import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandedText extends StatefulWidget {
  final String text;
  TextStyle? style;
  ExpandedText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 100) {
      isExpanded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(
      style: const TextStyle(color: Colors.black),
      children: [
        TextSpan(text: isExpanded ? widget.text : widget.text.substring(0, 100), style: widget.style),
        if (!isExpanded) ...[
          const TextSpan(text: "... "),
          TextSpan(text: "Xem thêm", style: const TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()
            ..onTap = () => setState(() {
              isExpanded = true;
            })
          ),
        ],
      ]
    ));
  }
}