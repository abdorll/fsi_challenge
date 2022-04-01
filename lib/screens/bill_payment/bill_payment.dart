import 'package:flutter/material.dart';
import 'package:fsi_app/screens/bill_payment/bill_categories.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:fsi_app/helpers/Alerts.dart';
import 'package:fsi_app/screens/banks_page.dart';
import 'package:fsi_app/services/all_apis_calling.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:provider/provider.dart';

class BillPaymentPage extends StatefulWidget {
  const BillPaymentPage({Key? key}) : super(key: key);

  @override
  State<BillPaymentPage> createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: IconOf(Icons.arrow_back_ios_new_rounded, black, 20),
          onTap: () {
            Navigation.previous(context);
          },
        ),
        backgroundColor: white,
        centerTitle: true,
        title: TextOf('Pay bill', 20, FontWeight.w500, black),
      ),
      body: SafeArea(
        child: SideSpace(10, 10, SingleChildScrollView(child:
            Consumer<BillPaymentProvider>(builder: ((context, value, child) {
          Future.delayed(const Duration(milliseconds: 500), () {});
          value.settype = BillCategoriesPage.type ?? '';
          return Column(
            children: [
              UserInputField((e) => value.setcustomer = e, 'Receiver',
                  'Customer', TextInputType.number),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextOf('Bill type', 20, FontWeight.w300, black),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigation.previous(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ash)),
                  child: SideSpace(
                      10,
                      14,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextOf(BillCategoriesPage.type ?? 'Bill category', 20,
                              FontWeight.w300, black),
                          IconOf(Icons.arrow_drop_down_rounded, black, 20)
                        ],
                      )),
                ),
              ),
              YSpace(5),
              UserInputField((e) => value.setamount = e, 'Amount',
                  'Transfer amount', TextInputType.number),
              YSpace(30),
              value.formValidity == true
                  ? InkWell(
                      onTap: () {
                        print("trying to pay bill");
                        value.createTransfer(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: white, width: 2),
                            color: orange,
                            borderRadius: BorderRadius.circular(13)),
                        child: Center(
                          child: SideSpace(30, 15,
                              TextOf("Pay bill", 20, FontWeight.w800, white)),
                        ),
                      ))
                  : InkWell(
                      child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: white, width: 2),
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(13)),
                      child: Center(
                        child: SideSpace(30, 15,
                            TextOf("Pay bill", 20, FontWeight.w800, white)),
                      ),
                    ))
            ],
          );
        })))),
      ),
    );
  }
}

class BillPaymentProvider extends BaseProvider {
  String? _customer;
  String? _amount;
  String? _type;
  bool formValidity = false;

  String get customer => _customer ?? '';
  String get amount => _amount ?? '';
  String get type => _type ?? '';

  set setcustomer(String customer) {
    _customer = customer;
    checkFormValidity();
    notifyListeners();
  }

  set setamount(String amount) {
    _amount = amount;
    checkFormValidity();
    notifyListeners();
  }

  set settype(String type) {
    _type = type;
    checkFormValidity();
    notifyListeners();
  }

  void checkFormValidity() {
    if ((customer != '') &&
        (amount != '') &&
        (type != '') &&
        (amount.length > 1)) {
      formValidity = true;
    } else {
      formValidity = false;
    }
    notifyListeners();
  }

  void createTransfer(BuildContext context) async {
    try {
      if (customer == '' || amount == '' || type == '') {
        Alerts.errorAlert(context, 'All fields are required', () {
          Navigator.pop(context);
        });
      } else {
        Alerts.loadingAlert(context, 'Paying bill...');

        FocusScope.of(context).unfocus();
        setLoading = true;
        var registerResponse = await AllApiOperations.createBillPayment(
          country: 'NG',
          customer: _customer,
          amount: _amount,
          recurrence: 'ONCE',
          type: _type,
          reference: 9300049404444,
        );
        Navigation.previous(context);
        // print(registerResponse['resposeCode']);
        // // ignore: avoid_print
        // print("Weisle register Response is $registerResponse");
        if (registerResponse['status'] == 'success') {
          setLoading = false;
          print('Request Successful');

          Alerts.successAlert(context, 'Bill payment successful', () {
            Navigation.previous(context);
          });
        } else {
          setLoading = false;
          Navigation.previous(context);
          Alerts.errorAlert(context, 'Transfer failed', () {
            Navigator.pop(context);
          });
          notifyListeners();
        }
      }
    } catch (e) {
      setLoading = false;
      Navigation.previous(context);
      Future.delayed(Duration(seconds: 1000), () {
        Alerts.errorAlert(context, 'Something went wrong', () {
          Navigator.pop(context);
        });
      });

      print(e);
    }
  }

  BillPaymentProvider() {
    checkFormValidity();
  }
}
