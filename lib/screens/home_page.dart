// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fsi_app/screens/banks_page.dart';
import 'package:fsi_app/screens/bill_payment/bill_categories.dart';
import 'package:fsi_app/screens/bill_payment/bill_payment.dart';
import 'package:fsi_app/screens/bill_payment/bulk_payment.dart';
import 'package:fsi_app/screens/bill_payment/payment_date_range.dart';
import 'package:fsi_app/screens/save_money/create_savings_plan.dart';
import 'package:fsi_app/screens/save_money/get_my_savings_plans.dart';
import 'package:fsi_app/screens/transfer_money/my_transfers.dart';
import 'package:fsi_app/screens/transfer_money/create_transfer.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/utils/constants.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    var now = int.parse(DateFormat('kk').format(time));
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWeisleBackDialogue();
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.orange.shade800,
                ),
                child: SideSpace(
                    10,
                    10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextOf('Hi user...', 20, FontWeight.w400, white),
                            TextOf(
                                (now < 12)
                                    ? 'Good morning💭'
                                    : ((now > 12) && (now <= 16))
                                        ? 'Good afernoon🌤️'
                                        : ((now > 16) && (now < 20))
                                            ? 'Good evening🌕'
                                            : "Good night 🌒",
                                25,
                                FontWeight.w500,
                                white)
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: SideSpace(
                  10,
                  10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextOf('Categories', 20, FontWeight.w500, black)
                    ],
                  ),
                ),
              ),
              YSpace(5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    SideSpace(
                      10,
                      0,
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextOf(
                                  'MONEY TRANSFER', 17, FontWeight.w300, black)
                            ],
                          ),
                        ],
                      ),
                    ),
                    transactionGetGridView(),
                    YSpace(10),
                    SideSpace(
                      10,
                      0,
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextOf('SAVE MONEY', 17, FontWeight.w300, black)
                            ],
                          ),
                        ],
                      ),
                    ),
                    saveGetGridView(),
                    YSpace(10),
                    SideSpace(
                      10,
                      0,
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextOf('BILL PAYMENT', 17, FontWeight.w300, black)
                            ],
                          ),
                        ],
                      ),
                    ),
                    billGridView(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/esusu_pay_gif.gif',
                          height: 50,
                          width: 50,
                        ),
                        XSpace(7),
                        TextOf('Powered by Esusu Africa', 15, FontWeight.w400,
                            orange),
                      ],
                    ),
                  ]),
                ),

                // Expanded(
                //     child: Column(
                //   children: [

                //       ],
                //     ),
                //   ],
                // )
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _selectedIndex = -1;
  Widget createTile(int index, int selectedIndex, bool isEven, String title,
      IconData icon, Color color, Widget action) {
    return Padding(
      padding: EdgeInsets.only(
          left: isEven ? 15 : 15, right: isEven ? 15 : 15, top: 1, bottom: 1),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });

          _selectedIndex == index
              ? Navigation.withReturn(context, action)
              : () {};
        },
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconOf(icon, white, 40),
              TextOfDecoration(
                  title, 20, FontWeight.w500, white, TextAlign.left)
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionGetGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      primary: false,
      childAspectRatio: 1.5,
      crossAxisSpacing: 2,
      //mainAxisSpacing: 0,
      children: [
        createTile(
            0,
            _selectedIndex,
            true,
            "Transfer money",
            Icons.monetization_on_outlined,
            Colors.green.shade500,
            GetAllBanksPage()),
        createTile(1, _selectedIndex, true, "My transfers",
            Icons.account_balance_wallet_outlined, fadedBlue, MyTransfers()),
      ],
    );
  }

  Widget saveGetGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      primary: false,
      childAspectRatio: 1.5,
      crossAxisSpacing: 2,
      //mainAxisSpacing: 0,
      children: [
        createTile(
            2,
            _selectedIndex,
            true,
            "Create plan",
            Icons.monetization_on_outlined,
            Colors.purple.shade500,
            CreateSavingsPlansPage()),
        createTile(
            3,
            _selectedIndex,
            true,
            "My savings",
            Icons.account_balance_wallet_outlined,
            Colors.red.shade700,
            GetMySavingsPlansPage()),
      ],
    );
  }

  Widget billGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      primary: false,
      childAspectRatio: 1.5,
      crossAxisSpacing: 2,
      //mainAxisSpacing: 0,
      children: [
        createTile(
            4,
            _selectedIndex,
            true,
            "Pay bill",
            Icons.monetization_on_outlined,
            Colors.yellow.shade800,
            BillCategoriesPage()),
        createTile(
            5,
            _selectedIndex,
            true,
            "My payments",
            Icons.account_balance_wallet_outlined,
            Colors.pink.shade500,
            PaymentDate()),
      ],
    );
  }

  Future<bool?> showWeisleBackDialogue() {
    return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: TextOf("Quitting esusuSave", 20, FontWeight.w500, black),
              content: TextOf("Are you sure you want to quit esusuSave?", 17,
                  FontWeight.w400, black),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: TextOf("Yes", 17, FontWeight.w500, ash),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: TextOf("No", 17, FontWeight.w500, orange),
                )
              ],
            ));
  }
}

class Categories extends StatelessWidget {
  IconData icon;
  Function action;
  String message;
  Categories(
    this.icon,
    this.action,
    this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Tooltip(
        message: message,
        child: SideSpace(
          5,
          2,
          Container(
            height: 60,
            width: 60,
            child: IconOf(icon, blue, 40),
            decoration: BoxDecoration(
                color: white,
                border: Border.all(color: blue),
                borderRadius: BorderRadius.circular(1000)),
          ),
        ),
      ),
    );
  }
}
