import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class Conexao
{
  Connectivity isConector;
  StreamSubscription isAtualizado;
  bool isConectado;
  String tipoConexao;
  Conexao() {
    this.isConectado=false;
    this.tipoConexao="";
    this.isConector = Connectivity();
    this.atualizar_verificacao2();
    //isAtualizado =  Connectivity().onConnectivityChanged.listen(verificar_conexao);
  }

  Future<void> atualizar_verificacao2() async {
    await this.isConector.checkConnectivity().then((value){
      verificar_conexao(value);
    });
  }

  String ip()
  {
    return("http://www15.itrack.com.br/");
  }

  Future<dynamic> httpPost(String caminho,var param) async
  {
    await this.atualizar_verificacao2();
    if(this.isConectado)
    {
      caminho=ip()+caminho;
      var response = await http.post(caminho,body:param);
      //dynamic parsedResponse = jsonDecode(response.body);
      return response.body;
    }
    else
    {
      return jsonEncode("sem conexao");
    }
  }

  Future<dynamic> httpGet(String caminho) async
  {
    await this.atualizar_verificacao2();
    if(this.isConectado)
    {
      caminho=ip()+caminho;
      var response = await http.get(caminho);
      return response.body;
    }
    else
    {
      return jsonEncode("sem conexao");
    }
  }

  void verificar_conexao(ConnectivityResult value) {
    if(value == ConnectivityResult.mobile)
    {
      this.isConectado=true;
      this.tipoConexao="Movel";
    }
    else if(value == ConnectivityResult.wifi)
    {
      this.isConectado=true;
      this.tipoConexao="Wi-fi";
    }
    else
    {
      this.isConectado=false;
      this.tipoConexao="";
    }
    print('Conexao isConectado => '+isConectado.toString()+" Tipo Conexao => "+this.tipoConexao);
  }

}