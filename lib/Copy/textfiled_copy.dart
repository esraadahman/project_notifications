import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard

class HomeScreen2 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter text to copy",
                ),
              ),
            ),
            const SizedBox(height: 20),
            CopyLinkButton(controller: _textController),
          ],
        ),
      ),
    );
  }
}

class CopyLinkButton extends StatefulWidget {
  final TextEditingController controller;

  const CopyLinkButton({Key? key, required this.controller});

  @override
  State<CopyLinkButton> createState() => _CopyLinkButtonState();
}

class _CopyLinkButtonState extends State<CopyLinkButton> {
  bool _isCopied = false;

  void _copyText() {
    String textToCopy = widget.controller.text.trim();

    if (textToCopy.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: textToCopy));

      setState(() {
        _isCopied = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Copied: $textToCopy")),
      );

      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isCopied = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _copyText,
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
              _isCopied ? ' Copied' : ' Copy Text',
            ),
          ],
        ),
      ),
    );
  }
}
