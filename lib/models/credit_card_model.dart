import 'package:hive/hive.dart';

part 'credit_card_model.g.dart';

@HiveType(typeId: 0)
class CreditCard extends HiveObject {
  @HiveField(0)
  late String? cardNumber;

  @HiveField(1)
  late String? expiredDate;

  @HiveField(2)
  late String? cardType;

  @HiveField(3)
  late String? cardImage;

  CreditCard({this.cardNumber, this.expiredDate, this.cardType, this.cardImage});
}
