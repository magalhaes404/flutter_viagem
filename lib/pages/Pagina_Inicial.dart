
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carro/metodo/Carro.dart';
import 'package:flutter_carro/metodo/Conexao.dart';
import 'package:flutter_carro/pages/Pagina_Viagem.dart';

class Pagina_Inicial extends StatefulWidget {
  Pagina_InicialState createState() => Pagina_InicialState();
}

class Pagina_InicialState extends State<Pagina_Inicial>
{
  Conexao rede = new Conexao();
  @override
  Widget build(BuildContext context) {
    String link = "recruitmentpositionapi/vehicles";
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
                        CircularProgressIndicator(),
                        Text('Carregando')
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
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => new Pagina_Inicial(),));
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
                  List<Carro> carros = json.map<Carro>((tmp) => Carro.fromJson(tmp)).toList();
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
                                   Expanded(child: Text('Lista de carros'))
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
                                 leading: Icon(Icons.directions_car_rounded,color: Colors.blue,size: 25,),
                                 title: Text(carros.elementAt(i).getMarca()+" "+carros.elementAt(i).getNome()),
                                 subtitle: Text(carros.elementAt(i).getDescricao()),
                                 onTap: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => Pagina_Viagem(carros.elementAt(i)),));
                                 },
                               );
                          },
                          childCount:carros.length,
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