import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colorFundo = List.generate(9, (index) => Colors.grey);
  List<String> textFundo = List.generate(9, (index) => "");
  String jogador = "X";
  String proximoJogador = "É a vez do jogador ";
  bool ganhador = false;
  int count = 0;
  Color corJogador = Colors.black;
  FontWeight font = FontWeight.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Jogo da Velha",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  for (int i = 0; i < 9; i++) {
                    colorFundo[i] = Colors.grey;
                    textFundo[i] = "";
                    jogador = "X";
                    proximoJogador = "É a vez do jogador ";
                    ganhador = false;
                    count = 0;
                    corJogador = Colors.black;
                    font = FontWeight.normal;
                  }
                });
              },
              child: const Text(
                "Reiniciar",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(children: [
        Expanded(
          flex: 8,
          child: GridView.builder(
              padding: const EdgeInsets.only(
                  left: 70, right: 70, bottom: 0, top: 20),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (ganhador == false &&
                          colorFundo[index] == Colors.grey) {
                        _verificaJogador(index);
                      }
                    });
                  },
                  child: Container(
                    color: colorFundo.elementAt(index),
                    child: Center(
                        child: Text(
                      textFundo.elementAt(index).toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 70,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                );
              }),
        ),
        Expanded(
            flex: 1,
            child: Center(
                child: Text(proximoJogador,
                    style: TextStyle(
                        fontSize: 20, fontWeight: font, color: corJogador)))),
        Expanded(
            flex: 2,
            child: Center(
                child: Text(
              jogador,
              style:
                  TextStyle(color: corJogador, fontSize: 80, fontWeight: font),
            ))),
      ]),
    );
  }

  _verificaJogador(index) {
    if (colorFundo[index] == Colors.grey) {
      if (jogador == "X") {
        colorFundo[index] = Colors.blue;
        jogador = "O";
        textFundo[index] = "X";
      } else {
        colorFundo[index] = Colors.red;
        jogador = "X";
        textFundo[index] = "O";
      }
    }
    count++;
    _verificaGanhador(index);
  }

  _verificaGanhador(index) {
    if (textFundo[0] == textFundo[1] &&
        textFundo[0] == textFundo[2] &&
        colorFundo[0] != Colors.grey) {
      _atualizarGanhador(textFundo[0]);
    }
    if (textFundo[3] == textFundo[4] &&
        textFundo[3] == textFundo[5] &&
        colorFundo[3] != Colors.grey) {
      _atualizarGanhador(textFundo[3]);
    }
    if (textFundo[6] == textFundo[7] &&
        textFundo[6] == textFundo[8] &&
        colorFundo[6] != Colors.grey) {
      _atualizarGanhador(textFundo[6]);
    }
    if (textFundo[0] == textFundo[3] &&
        textFundo[0] == textFundo[6] &&
        colorFundo[0] != Colors.grey) {
      _atualizarGanhador(textFundo[0]);
    }
    if (textFundo[1] == textFundo[4] &&
        textFundo[1] == textFundo[7] &&
        colorFundo[1] != Colors.grey) {
      _atualizarGanhador(textFundo[1]);
    }
    if (textFundo[2] == textFundo[5] &&
        textFundo[2] == textFundo[8] &&
        colorFundo[2] != Colors.grey) {
      _atualizarGanhador(textFundo[2]);
    }
    if (textFundo[0] == textFundo[4] &&
        textFundo[0] == textFundo[8] &&
        colorFundo[0] != Colors.grey) {
      _atualizarGanhador(textFundo[0]);
    }
    if (textFundo[2] == textFundo[4] &&
        textFundo[2] == textFundo[6] &&
        colorFundo[2] != Colors.grey) {
      _atualizarGanhador(textFundo[2]);
    }
    if (count > 8 && ganhador == false) {
      setState(() {
        proximoJogador = "Tente outra vez";
        font = FontWeight.bold;
        corJogador = Colors.red;
        jogador = "";
      });
    }
  }

  _atualizarGanhador(index) {
    setState(() {
      proximoJogador = "Parabens jogador";
      corJogador = Colors.green;
      font = FontWeight.bold;
      jogador = index;
      ganhador = true;
    });
  }
}
