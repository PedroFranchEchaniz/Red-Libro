class RatingDto {
  Id? id;
  double? stars;
  String? opinion;

  RatingDto({this.id, this.stars, this.opinion});

  RatingDto.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    stars = json['stars'];
    opinion = json['opinion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    data['stars'] = this.stars;
    data['opinion'] = this.opinion;
    return data;
  }
}

class Id {
  String? clientId;
  String? bookIsbn;

  Id({this.clientId, this.bookIsbn});

  Id.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    bookIsbn = json['bookIsbn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    data['bookIsbn'] = this.bookIsbn;
    return data;
  }
}
