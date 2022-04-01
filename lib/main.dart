import 'package:flutter/material.dart';
import 'package:fsi_app/providers/getAllBanks.dart';
import 'package:fsi_app/screens/banks_page.dart';
import 'package:fsi_app/screens/bill_payment/bill_categories.dart';
import 'package:fsi_app/screens/bill_payment/bill_payment.dart';
import 'package:fsi_app/screens/bill_payment/payment_date_range.dart';
import 'package:fsi_app/screens/home_page.dart';
import 'package:fsi_app/screens/login_screen.dart';
import 'package:fsi_app/screens/save_money/create_savings_plan.dart';
import 'package:fsi_app/screens/save_money/get_my_savings_plans.dart';
import 'package:fsi_app/screens/splash_screen.dart';
import 'package:fsi_app/screens/transfer_money/create_transfer.dart';
import 'package:fsi_app/screens/transfer_money/my_transfers.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  await Hive.openBox(userDetailsBox);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) => GetAllBanksProvider())),
      ChangeNotifierProvider(create: ((context) => LoginProvider())),
      ChangeNotifierProvider(
          create: ((context) => MyPaymentsProvider(context))),
      ChangeNotifierProvider(
          create: ((context) => GetMySavingsPlansPageProvider())),
      ChangeNotifierProvider(create: ((context) => MyTransfersProvider())),
      ChangeNotifierProvider(create: ((context) => BillPaymentProvider())),
      ChangeNotifierProvider(
          create: ((context) => GetBillCategoriesProvider())),
      ChangeNotifierProvider(create: ((context) => CreateSavingsProvider())),
      ChangeNotifierProvider(create: ((context) => CreateTransferProvider()))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'esusuSave',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SplashScreeen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
