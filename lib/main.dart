import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nosql_db/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';

import 'models/credit_card_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDirectory.path)
    ..registerAdapter(CreditCardAdapter());
  await Hive.openBox("my_nosql");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
