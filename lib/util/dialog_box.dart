import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[200],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          // Get User Input
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Tambahkan Kegiatan Baru",
              ),
          ),

          // button (simpan dan batal)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // simpan 
              MyButton(
                text: "Simpan", 
                onPressed: onSave
                ),
              const SizedBox(width: 8),
              // batal 
              MyButton(
                text: "Batal", 
                onPressed: onCancel
                ),
            ],
          )

        ]),
      ),
    );
  }
}

