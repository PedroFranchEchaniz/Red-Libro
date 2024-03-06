class RatingResponse {
  String? userName;
  int? valoracion;
  String? comentario;

  RatingResponse({this.userName, this.valoracion, this.comentario});

  RatingResponse.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    valoracion = json['valoracion'];
    comentario = json['comentario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['valoracion'] = this.valoracion;
    data['comentario'] = this.comentario;
    return data;
  }
}
