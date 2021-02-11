class Posicao{

  int id,hodometro;
  DateTime data;
  String endereco,latitude,longitude;
  bool ignicao;

  Posicao()
  {
    this.id=-1;
    this.longitude="";
    this.latitude="";
    this.data=null;
    this.endereco="";
    this.ignicao=false;
    this.hodometro=-1;
  }


  void setId(int id)
  {
    this.id=id;
  }

  void setLatitude(String latitude)
  {
    this.latitude=latitude;
  }

  void setLongitude(String longitude)
  {
    this.longitude=longitude;
  }

  void setData(int milesecond)
  {
    this.data = new DateTime.fromMicrosecondsSinceEpoch(milesecond);
  }

  void setIgnicao(bool ignicao)
  {
    this.ignicao=ignicao;
  }
  
  void setHodometro(int hodometro)
  {
    this.hodometro=hodometro;
  }

  void setEndereco(String endereco)
  {
    this.endereco=endereco;
  }
  
  int getId()
  {
    return this.id;
  }

  String getLatitude()
  {
    return this.latitude;
  }

  String getLongitude()
  {
    return this.longitude;
  }

  DateTime getData()
  {
    return this.data;
  }

  bool getIgnicao()
  {
    return this.ignicao;
  }

  int getHodometro()
  {
    return this.hodometro;
  }

  String getEndereco()
  {
    return this.endereco;
  }
  factory Posicao.fromJson(Map<String, dynamic> dados) {
      Posicao tmp = new Posicao();
      tmp.setId(int.parse(dados['id'].toString()));
      tmp.setLatitude(dados['latitude'].toString());
      tmp.setLongitude(dados['longitude'].toString());
      tmp.setData(int.parse(dados['datetime'].toString()));
      tmp.setHodometro(int.parse(dados['hodometro'].toString()));
      tmp.setIgnicao(dados['ignition'].toString().contains("true"));
      tmp.setEndereco(dados['address'].toString());
      return tmp;
  }

}