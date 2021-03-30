function doGet() {
  var sheet = SpreadsheetApp.openById("1kkc-rEEyM7bv5CaUc41jtwabTwEXVofZfHCLVwt_L-Q");

  var values = sheet.getActiveSheet().getDataRange().getValues();
  var data = [];

  for (var i = 1; i < values.length; i++) {

    var row = values[i];

    var card = {};

    card['front'] = row[0];
    card['back'] = row[1];
    card['serious'] = row[2];

    data.push(card);
  }

  return ContentService
  .createTextOutput(JSON.stringify(data))
  .setMimeType(ContentService.MimeType.JSON)
}

