class Usuario {
  String idUsu;
  String usuario;
  String email;
  int estado;
  String ruta;
  String permisos;
  int statuscode;
  int codigo;
  String mensaje;
  String token;

  Usuario(
      {this.idUsu,
      this.usuario,
      this.email,
      this.estado,
      this.ruta,
      this.permisos,
      this.statuscode,
      this.codigo,
      this.mensaje,
      this.token});

  Usuario.fromJson(Map<String, dynamic> json) {
    idUsu = json['id_usu'];
    usuario = json['usuario'];
    email = json['email'];
    estado = json['estado'];
    ruta = json['ruta'];
    permisos = json['permisos'];
    statuscode = json['statuscode'];
    codigo = json['codigo'];
    mensaje = json['mensaje'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_usu'] = this.idUsu;
    data['usuario'] = this.usuario;
    data['email'] = this.email;
    data['estado'] = this.estado;
    data['ruta'] = this.ruta;
    data['permisos'] = this.permisos;
    data['statuscode'] = this.statuscode;
    data['codigo'] = this.codigo;
    data['mensaje'] = this.mensaje;
    data['token'] = this.token;
    return data;
  }
}