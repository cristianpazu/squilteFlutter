import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearcgForm extends StatefulHookWidget {
  const SearcgForm({Key? key, required this.buscar}) : super(key: key);
  final StateController<String> buscar;
  @override
  State<SearcgForm> createState() => _SearcgFormState();
}

class _SearcgFormState extends State<SearcgForm> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(29.5)),
      child: TextFormField(
        
        controller: _textEditingController,
        onChanged: (value) => widget.buscar.state = value,
   
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
            filled: true, fillColor: Colors.white, hintText: "Buscar producto"),
      ),
    );
  }
}
