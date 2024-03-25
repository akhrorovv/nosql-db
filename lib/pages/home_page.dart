import 'package:flutter/material.dart';
import 'package:nosql_db/services/hive_service.dart';

import '../models/credit_card_model.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cards = [];

  Future openDetailsPage() async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const DetailsPage();
        },
      ),
    );

    loadCards();
  }

  Future openUpdatePage(CreditCard creditCard) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return DetailsPage(
            creditCard: creditCard,
            index: cards.indexOf(creditCard),
          );
        },
      ),
    );

    loadCards();
  }

  loadCards() {
    var myCards = HiveService.getAllCreditCards();
    setState(() {
      cards = myCards;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My cards')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: cards.isEmpty
                  ? const Center(
                      child: Text('No Cards'),
                    )
                  : ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (ctx, i) {
                        return _itemOfCardList(cards[i], i);
                      },
                    ),
            ),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
              child: MaterialButton(
                onPressed: () {
                  openDetailsPage();
                },
                child: const Text(
                  'Add Card',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  deleteCard(int index) async {
    setState(() {
      cards.removeAt(index);
      HiveService.deleteCreditCardByIndex(index);
    });
  }

  openDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text("Delete card"),
          content: const Text("Are you sure you want to delete card?"),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  deleteCard(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _itemOfCardList(CreditCard card, int index) {
    return GestureDetector(
      onLongPress: () {
        openDialog(index);
      },
      onTap: () {
        openUpdatePage(card);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(5),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: Image(image: AssetImage(card.cardImage!)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '**** **** **** ${card.cardNumber!.substring(card.cardNumber!.length - 4)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  card.expiredDate!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
