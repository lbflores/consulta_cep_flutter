class Cep {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;


  Cep({required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf});

  Cep.fromJson(Map<String, dynamic> json)
      : this(
    cep: json['cep'],
    logradouro: json['logradouro'],
    complemento: json['complemento'],
    bairro: json['bairro'],
    localidade: json['localidade'],
    uf: json['uf'],
  );

  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
    };
  }


}
