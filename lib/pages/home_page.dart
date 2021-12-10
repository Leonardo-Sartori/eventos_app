import 'dart:convert';
import 'package:eventos_app/data/models/eventos.dart';
import 'package:eventos_app/pages/formulario_eventos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final http.Client _client = http.Client();
  List<dynamic> todosEventos = <dynamic>[];

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eventos App"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.grey[700],
                      minimumSize: Size(150, 35),
                    ),
                    onPressed: () {
                      getAll();
                    },
                    child: const Text(
                      "BUSCAR DADOS DA API",
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.grey[700],
                      minimumSize: Size(150, 35),
                    ),
                    onPressed: () {
                      // delete();
                    },
                    child: const Text(
                      "DELETAR DADOS DA API",
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.grey[700],
                      minimumSize: Size(150, 35),
                    ),
                    onPressed: () {
                      // insert();
                    },
                    child: const Text(
                      "INSERIR DADOS DA API",
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.grey[700],
                      minimumSize: Size(150, 35),
                    ),
                    onPressed: () {
                      update();
                    },
                    child: const Text(
                      "ATUALIZAR REGISTRO DA API",
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.grey[700],
                      minimumSize: Size(150, 35),
                    ),
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => FormularioEventos(nomeEvento: "Festa de final de ano",),
                        ),
                      );
                    },
                    child: const Text(
                      "IR PARA EDIÇÃO",
                    )),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todosEventos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(todosEventos[index].id.toString()),
                    trailing: IconButton(
                      onPressed: () async => {
                        print(todosEventos[index].id),
                        await delete(todosEventos[index].id),
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    title: Text(todosEventos[index].nome),
                    subtitle: Text(todosEventos[index].local),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic>? delete(int id) async {
    await _client
        .get(Uri.parse(
            "https://www.limeiraweb.com.br/api_eventos/excluir.php?id=$id"))
        .then((http.Response res) {
      if (res.statusCode == 200) {
        print("REGISTRO DELETADO");
      } else {
        print("ERRO AO DELETAR REGISTRO: ${res.statusCode}");
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<dynamic>? insert(Eventos evento) async {
    await _client
        .post(
            Uri.parse("https://www.limeiraweb.com.br/api_eventos/inserir.php"),
            body: evento.toMap())
        .then((http.Response res) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        print("REGISTRO INSERIDO");
      } else {
        print("ERRO AO INSERIR: CÓDIGO ${res.statusCode}");
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<dynamic>? update() async {
    await _client.post(
        Uri.parse("https://www.limeiraweb.com.br/api_eventos/alterar.php"),
        body: {
          "id": "31",
          "nome": "Antigo 31",
          "dataEvento": DateTime.now().toString(),
          "local": "ANTIGO Pavilhao",
          "observacao": "TODAS as obs",
          "valorEntrada": "25.00",
          "foto": "alguma_foto.jpeg"
        }).then((http.Response res) {
      if (res.statusCode == 200) {
        print("REGISTRO ATUALIZADO");
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<List<Eventos?>?> getAll() async {
    todosEventos = [];

    try {
      await _client
          .get(
              Uri.parse("https://www.limeiraweb.com.br/api_eventos/listar.php"),
              headers: _headers)
          .then((http.Response res) {
        if (res.statusCode == 200) {
          dynamic data = jsonDecode(res.body);
          for (var i in data) {
            todosEventos.add(Eventos(
              id: i["id"],
              nome: i["nome"] != null ? i["nome"] : "",
              dataEvento: i["dataEvento"] != null
                  ? DateTime.parse(i["dataEvento"])
                  : DateTime.now(),
              foto: i["foto"] != null ? i["foto"] : "",
              local: i["local"] != null ? i["local"] : "",
              observacao: i["observacao"] != null ? i["observacao"] : "",
              valorEntrada: i["valorEntrada"] != null
                  ? double.parse(i["valorEntrada"])
                  : 0,
            ));
          }

          return todosEventos;
        } else {
          return null;
        }
      });
    } catch (e) {
      print("Erro ao se comunicar com o servidor!!!");
      print(e);
      return null;
    }

    setState(() {});
  }
}
