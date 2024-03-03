import 'package:hive/hive.dart';
import 'package:nosql_db/models/credit_card_model.dart';

class HiveService {
  static var box = Hive.box('my_nosql');

  /// Save object without key
  static saveCreditCard(CreditCard creditCard) async {
    box.add(creditCard);
  }

  static updateCreditCard(int index,CreditCard creditCard) async {
    box.putAt(index, creditCard);
  }

  static List<CreditCard> getAllCreditCards() {
    // List creditCards = box.values.toList();
    List<CreditCard> creditCards = [];
    for (int i = 0; i < box.length; i++) {
      var card = box.getAt(i);
      creditCards.add(card);
    }
    return creditCards;
  }

  static deleteCreditCardByIndex(int index) async {
    box.deleteAt(index);
  }
}
