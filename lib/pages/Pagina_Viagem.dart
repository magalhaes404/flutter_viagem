
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carro/metodo/Carro.dart';
import 'package:flutter_carro/metodo/Conexao.dart';
import 'package:flutter_carro/metodo/Posicao.dart';
import 'package:flutter_carro/metodo/Viagem.dart';
import 'package:flutter_carro/pages/Pagina_Posicao.dart';

class Pagina_Viagem extends StatefulWidget {
  Carro carro;
  Pagina_Viagem(Carro carro)
  {
    this.carro=carro;
  }

  Pagina_ViagemState createState() => Pagina_ViagemState(carro);
}

class Pagina_ViagemState extends State<Pagina_Viagem>
{
  Conexao rede;
  Carro carro;
  Pagina_ViagemState(Carro carro)
  {
    this.rede=new Conexao();
    this.carro=carro;
  }

  @override
  Widget build(BuildContext context) {
    String link = "recruitmentpositionapi/vehicles/"+carro.getId().toString()+"/positions";
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          icon: Icon(Icons.build),
        ),
      ),
      body: Card(
          child: FutureBuilder(
            future: rede.httpGet(link),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(child: CircularProgressIndicator()),
                      Expanded(child: Text('Carregando'))
                    ],
                  ),
                );
              }
              else if(snapshot.connectionState == ConnectionState.done)
              {
                print('Json => '+snapshot.data.toString());
                var json = jsonDecode(snapshot.data);
                if(json.toString().contains("sem conexao"))
                {
                  return Container(
                    color: Colors.redAccent,
                    child: ListView(
                      children: [
                        ListTile(
                          title: Center(
                            child: Icon(Icons.error,color: Colors.white,size: 200,),
                          ),
                        ),
                        ListTile(
                            title: Center(
                              child: Text('Sem conexão com a internet',style: TextStyle(color: Colors.white,fontSize: 15),),
                            )
                        ),
                        ListTile(
                          title: Center(
                            child: Text('Verifique se a sua conexão com a internet esta ativa.'),
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => new Pagina_Viagem(carro),));
                                },
                                child: Text('Tentar novamente',style: TextStyle(color: Colors.black,),),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                else
                {
                  double heigth = MediaQuery.of(context).size.height;
                  var json = jsonDecode(snapshot.data);
                  List<Posicao> posicoes = json.map<Posicao>((tmp) => Posicao.fromJson(tmp)).toList();
                  List<Posicao> tmp = new List<Posicao>();
                  List<Viagem> viagens = new List<Viagem>();
                  bool isViagem=false;
                  print('Lista pontos => '+posicoes.length.toString());
                  for(int i=0;i<posicoes.length;i++)
                    {
                      print('for i => '+i.toString());
                      if(posicoes.elementAt(i).getIgnicao())
                        {
                          print('posicao ignicao true');
                          if(isViagem == false)
                            {
                              tmp.clear();
                              print('nova viagem');
                              tmp.add(posicoes.elementAt(i));
                              Viagem viagem = new Viagem(carro.getId(), tmp);
                              viagens.add(viagem);
                              isViagem = true;
                            }
                          else
                            {
                              viagens.elementAt(viagens.length-1).posicoes.add(posicoes.elementAt(i));
                            }
                        }
                      else
                      {
                        isViagem=false;
                        if(posicoes.elementAt(i-1).getIgnicao())
                          {
                            viagens.elementAt(viagens.length-1).posicoes.add(posicoes.elementAt(i));
                          }
                      }
                    }
                  print('Viagem => '+viagens.length.toString());
                  return CustomScrollView(
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
                                  Expanded(child: Text('Viagem do '+carro.getMarca()+" "+carro.getModelo()))
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
                                      leading: Icon(Icons.directions,color: Colors.blue,size: 25,),
                                      title: Text('Viagem '+i.toString()),
                                      onTap: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => new Pagina_Posicao(carro,viagens.elementAt(i)),));
                                      },

                              );
                                },
                                childCount:viagens.length,
                          )
                      )
                    ],
                  );
                }
              }
              else
              {
                return Column(
                  children: [

                  ],
                );
              }
            },
          )
      ),
    );
  }

}