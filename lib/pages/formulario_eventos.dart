import 'package:flutter/material.dart';

class FormularioEventos extends StatefulWidget {
  String nomeEvento;

  FormularioEventos({required this.nomeEvento});

  @override
  _FormularioEventosState createState() => _FormularioEventosState();
}

class _FormularioEventosState extends State<FormularioEventos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeEvento),
      ),
      body: Container()
    );
  }
}