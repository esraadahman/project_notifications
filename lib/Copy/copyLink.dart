import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyLinkButton extends StatefulWidget {
  final String text;

  const CopyLinkButton({Key? key, required this.text});

  @override
  State<CopyLinkButton> createState() => _CopyLinkButtonState();
}

class _CopyLinkButtonState extends State<CopyLinkButton> {
  bool _isCopied = false;

  void _copyLink() {
    // this line is what copy text to  Clipboard
    Clipboard.setData(ClipboardData(text: widget.text));
    //////////////////
    setState(() {
      _isCopied = true;
    });

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isCopied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _copyLink,
      child: Container(
        width: 300,
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isCopied ? Icons.check : Icons.copy,
              color: _isCopied ? Colors.green : Colors.blue,
            ),
            Text(
              _isCopied ? ' Copied' : ' Copy Invitation Link',
            ),
          ],
        ),
      ),
    );
  }
}
