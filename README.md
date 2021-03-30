# retro-flutter

## Um projeto usando flip cards em flutter para uma sessão de retrospectiva ágil

![Exemplo](screenshot.png "Exemplo")

---

O "backend" é uma planilha do Google - [modelo](https://docs.google.com/spreadsheets/d/1kkc-rEEyM7bv5CaUc41jtwabTwEXVofZfHCLVwt_L-Q/edit?usp=sharing)

```dart
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
```

O código do script do [Google Apps Scripts](https://developers.google.com/apps-script) para servir o json com os dados está no arquivo [flipapi.gs](flipapi.gs)

## build

### web

`flutter build web --release`

## run

### local

```bash
cd build/web
python -m SimpleHTTPServer 8069
```

http://localhost:8069
