# retro-flutter

## Um projeto usando flip cards em flutter para uma sessão de retrospectiva ágil

![Exemplo](screenshot.png "Exemplo")

## Regras

O moderador ou responsável por conduzir a retrospectiva faz uma lista dos participantes e determina uma ordem aleatória.

Na sua vez, cada participante escolhe um card que não foi utilizado ainda e o moderador vira o card que determina a pergunta ou ação na qual o participante deverá atuar.

Há dois tipos de cards, um mais casual, descontraído ou divertido e outro que exige mais comprometimento, reflexão, argumentação e sustentação (serious = true). Recomenda-se gastar apenas alguns segundos no primeiro caso e mais tempo no segundo, inclusive dando oportunidade aos demais participantes de expor o seu ponto de vista. Ações de ajustes, correções e melhorias dos processos do time podem nascer a partir desta reflexão.

Recomenda-se que o moderador explique brevemente o que se espera de cada card escolhido, possivelmente com exemplos, com o intuito de engajar os participantes, tomando-se o devido cuidado de não influenciar sua resposta, apenas norteá-la.

O tempo gasto nesta dinâmica não deve ultrapassar 1 hora, a fim de não cansar a equipe. Não há problema algum se restarem alguns cards não revelados.

Outra ressalva importante é que quando for a vez do moderador escolher um card, os demais participantes devem fazê-lo por ele, pelo simples fato de que é muito provável que ele já conheça a ordem e conteúdo da maioria dos cards.

---

O "backend" é uma planilha do Google - [modelo](https://docs.google.com/spreadsheets/d/1kkc-rEEyM7bv5CaUc41jtwabTwEXVofZfHCLVwt_L-Q/edit?usp=sharing)

![Planilha](screenshot2.png "Planilha")

Trecho de código que obtém os dados da planilha como JSON:

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

O código do script do [Google Apps Scripts](https://developers.google.com/apps-script) para servir o json com os dados obtidos da planilha está no arquivo [flipapi.gs](flipapi.gs)

O arquivo [mock.json](mock.json) contém a resposta da requisição e pode ser usado em uma ferramenta de mock, como o [Mockoon](https://mockoon.com)

## compile and build

### install Flutter

[How to install Flutter on your platform of choice](https://flutter.dev/docs/get-started/install)

### check your installation

`flutter doctor`

### build for the web

```bash
cd ~/$PROJECT_FOLDER
flutter pub get
flutter build web --release
```

## run

### local

- iniciar um servidor web

```bash
cd ~/$PROJECT_FOLDER/build/web
python -m SimpleHTTPServer 8069
```
ou

`python -m http.server 8069`

(dependendo da sua versão do Python)

- abra o endereço http://localhost:8069 no browser

### hosted on S3

[Hosting a static web site using Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)

### or use another third party web hosting solution

[Deploying for the Web](https://flutter.dev/docs/deployment/web#deploying-to-the-web)

## dependências

- Para criar os cards, usei o package [flip_dart](https://github.com/fedeoo/flip_card)
- Para a requisição http usei uma lib assíncrona - [http](https://pub.dev/packages/http)
- Para análise estática e lint do código usei [analyzer](https://pub.dev/packages/analyzer) e [pedantic](https://pub.dev/packages/pedantic) que determinam boas práticas definidas em [Effective Dart](https://dart.dev/guides/language/effective-dart)

## leitura recomendada

- [A tour of the Dart language](https://dart.dev/guides/language/language-tour)
- [Learn Dart in Y minutes](https://learnxinyminutes.com/docs/dart/)
- [Flutter 2 Is Here: All You Need to Know After Flutter Engage.](https://medium.com/swlh/flutter-2-is-here-all-you-need-to-know-after-flutter-engage-98ef7cb1469e)
- [Google Apps Script - Content Service](https://developers.google.com/apps-script/guides/content)

## TODO

- [ ] unit tests
- [ ] múltiplos usuários dentro de uma sessão e só quem criou a sessão pode virar os cards
