import 'package:flutter/material.dart';

import '../models/credit_card_model.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CreditCard> cards = [
    CreditCard(
      cardNumber: '0000 0000 0000 0000',
      expiredDate: '12/12',
      cardType: 'master',
      cardImage: 'assets/images/ic_card_master.png',
    ),
    CreditCard(
      cardNumber: '8888 8888 8888 8888',
      expiredDate: '25/25',
      cardType: 'visa',
      cardImage: 'assets/images/ic_card_visa.png',
    ),
  ];

  Future openDetailsPage() async {
    CreditCard result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const DetailsPage();
        },
      ),
    );

    setState(() {
      cards.add(result);
    });

    // loadCards();
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
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (ctx, i) {
                  return _itemOfCardList(cards[i]);
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

  Widget _itemOfCardList(CreditCard card) {
    return GestureDetector(
      onLongPress: () {},
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