import 'card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CardApi {
  static Future<List<CardModel>> getCardList() async {
    var url =
        'https://script.google.com/macros/s/AKfycbw3PRc-UgVK7Ro3DYIiGcCRv0CR0oWrdr3O-eYAz7L3RXNqJgop6FPpaQCfyPHqa3ysPw/exec';
    return await http.get(url).then((response) {
      var jsonCard = convert.jsonDecode(response.body) as List;
      return jsonCard.map((json) => CardModel.fromJson(json)).toList();
    });
  }
}
