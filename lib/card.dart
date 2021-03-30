class CardModel {
  String front;
  String back;
  bool serious;

  CardModel(this.front, this.back, this.serious);

  factory CardModel.fromJson(dynamic json) {
    return CardModel(
        "${json['front']}",
        "${json['back']}",
        json['serious']
    );
  }

}