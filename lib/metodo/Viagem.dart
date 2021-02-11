import 'Posicao.dart';

class Viagem
{
  int idCarro;
  List<Posicao> posicoes;

  Viagem(int idCarro,List<Posicao> tmp)
  {
    this.posicoes=tmp;
    this.montar();
    this.idCarro=idCarro;
  }

  void montar()
  {
    List<Posicao> tmp = this.posicoes;
    this.posicoes=new List<Posicao>();
    for(int i=0;i<tmp.length;i++)
      {
        if(tmp.elementAt(i).getIgnicao() == true)
          {
            this.posicoes.add(tmp.elementAt(i));
          }
        else
          {
            i=tmp.length;
          }
      }
    print('length viagem posicao => '+this.posicoes.length.toString());
  }


}