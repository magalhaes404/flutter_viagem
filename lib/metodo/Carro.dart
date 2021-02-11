class Carro
{
    int id;
    String nome,descricao,modelo,marca;

    Carro()
    {
      this.id=-1;
      this.nome="";
      this.descricao="";
      this.modelo="";
      this.marca="";
    }

    void setId(int id)
    {
      this.id=id;
    }

    void setNome(String nome)
    {
      this.nome=nome;
    }

    void setDescricao(String descricao)
    {
      this.descricao=descricao;
    }

    void setMarca(String marca)
    {
      this.marca=marca;
    }
    void setModelo(String modelo)
    {
      this.modelo=modelo;
    }

    int getId()
    {
      return this.id;
    }

    String getNome()
    {
      return this.nome;
    }

    String getDescricao()
    {
      return this.descricao;
    }

    String getMarca()
    {
      return this.marca;
    }

    String getModelo()
    {
      return this.modelo;
    }

    factory Carro.fromJson(Map<String, dynamic> carro) {
      Carro tmp = new Carro();
        tmp.setId(int.parse(carro['id'].toString()));
        tmp.setNome(carro['name'].toString());
        tmp.setDescricao(carro['description'].toString());
        tmp.setModelo(carro['model'].toString());
        tmp.setMarca(carro['brand'].toString());
        return tmp;
    }

}