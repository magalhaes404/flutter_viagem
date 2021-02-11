import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carro/metodo/Carro.dart';
import 'package:flutter_carro/metodo/Conexao.dart';
import 'package:flutter_carro/metodo/Viagem.dart';
import 'package:flutter_carro/pages/Pagina_Viagem.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class Pagina_Posicao extends StatefulWidget {
  Carro carro;
  Viagem viagem;
  Pagina_Posicao(Carro carro,Viagem viagem)
  {
    this.carro=carro;
    this.viagem=viagem;
  }

  Pagina_PosicaoState createState() => Pagina_PosicaoState(carro,viagem);
}

class Pagina_PosicaoState extends State<Pagina_Posicao>
{
  Conexao rede;
  Carro carro;
  Viagem viagem;
  Pagina_PosicaoState(Carro carro,Viagem viagem)
  {
    this.rede=new Conexao();
    this.carro=carro;
    this.viagem=viagem;
  }

  @override
  Widget build(BuildContext context) {
    String link = "recruitmentpositionapi/vehicles/"+carro.getId().toString()+"/positions";
    double heigth = MediaQuery.of(context).size.height;
    print('Posicoes lista => '+viagem.posicoes.length.toString());
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => new Pagina_Viagem(carro),));
          },
        ),
      ),
      body: Card(
          child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                  height: heigth/4,
                  child: Card(
                      child: Container(
                        color: Colors.white,
                        child: Row(
                        children: [
                            Expanded(child: Icon(Icons.directions_car_sharp,size: 50,)),
                            Expanded(child: Text('Posições percorridas na Viagem '))
                        ],
                    ),
                  ),
              ),
            ),
          ),
                SliverToBoxAdapter(
                    child: Container(
                    color: Colors.lightGreen,
                    child: SizedBox(
                      height: heigth/80,
                    ),
                  ),
                ),
                SliverList(
                    delegate:SliverChildBuilderDelegate(
                      (BuildContext context,int i) {
                        return ListTile(
                          leading: Icon(Icons.circle,color: Colors.blue,size: 25,),
                          title: Text(viagem.posicoes.elementAt(i).getEndereco()),
                          subtitle: Text(DateFormat("dd/MM/yyyy").format(viagem.posicoes.elementAt(i).getData())),
                          );
                      },
                    childCount:viagem.posicoes.length,
                 )
                )
              ],
            )
        ),
      );
  }

}