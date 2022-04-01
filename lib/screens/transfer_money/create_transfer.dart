import 'package:flutter/material.dart';
import 'package:fsi_app/helpers/Alerts.dart';
import 'package:fsi_app/screens/banks_page.dart';
import 'package:fsi_app/services/all_apis_calling.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class CreateTransferPage extends StatefulWidget {
  const CreateTransferPage({Key? key}) : super(key: key);

  @override
  State<CreateTransferPage> createState() => _CreateTransferPageState();
}

class _CreateTransferPageState extends State<CreateTransferPage> {
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
        title: TextOf('Transfer money', 20, FontWeight.w500, black),
      ),
      body: SafeArea(
        child: SideSpace(10, 10, SingleChildScrollView(child:
            Consumer<CreateTransferProvider>(builder: ((context, value, child) {
          Future.delayed(const Duration(milliseconds: 500), () {});
          value.setaccount_bank = GetAllBanksPage.bankCode ?? '';
          return Column(
            children: [
              UserInputField((e) => value.setnarration = e, 'Transfer title',
                  'Narration', TextInputType.name),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextOf('Select bank', 20, FontWeight.w300, black),
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
                          TextOf(GetAllBanksPage.bankName ?? 'Bank name', 20,
                              FontWeight.w300, black),
                          IconOf(Icons.arrow_drop_down_rounded, black, 20)
                        ],
                      )),
                ),
              ),
              YSpace(5),
              UserInputField((e) => value.setaccount_number = e,
                  'Account number', 'Accout number', TextInputType.number),
              UserInputField((e) => value.setamount = e, 'Amount',
                  'Transfer amount', TextInputType.number),
              YSpace(30),
              InkWell(
                  onTap: () {
                    print("trying to transfer money");
                    value.createTransfer(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: white, width: 2),
                        color: orange,
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: SideSpace(30, 15,
                          TextOf("Transfer money", 20, FontWeight.w800, white)),
                    ),
                  )),
            ],
          );
        })))),
      ),
    );
  }
}

class CreateTransferProvider extends BaseProvider {
  String? _account_bank;
  String? _account_number;
  String? _amount;
  String? _narration;
  bool formValidity = false;

  String get account_bank => _account_bank ?? '';
  String get account_number => _account_number ?? '';
  String get amount => _amount ?? '';
  String get narration => _narration ?? '';

  set setaccount_bank(String account_bank) {
    _account_bank = account_bank;
    checkFormValidity();
    notifyListeners();
  }

  set setaccount_number(String account_number) {
    _account_number = account_number;
    checkFormValidity();
    notifyListeners();
  }

  set setamount(String amount) {
    _amount = amount;
    checkFormValidity();
    notifyListeners();
  }

  set setnarration(String narration) {
    _narration = narration;
    checkFormValidity();
    notifyListeners();
  }

  void checkFormValidity() {
    if ((_account_bank != null) &&
        (_account_number != null) &&
        (_amount != null) &&
        (_narration != null)) {
      formValidity = true;
    } else {
      formValidity = false;
    }
    notifyListeners();
  }

  void createTransfer(BuildContext context) async {
    try {
      if (account_bank == '' ||
          account_number == '' ||
          amount == '' ||
          narration == '') {
        Alerts.errorAlert(context, 'All fields are required', () {
          Navigator.pop(context);
        });
      } else if (_account_number!.length < 10 || _account_number!.length < 10) {
        Alerts.errorAlert(context, 'Make account number length be 10', () {
          Navigator.pop(context);
        });
      } else {
        Alerts.loadingAlert(context, 'Transferring...');

        FocusScope.of(context).unfocus();
        setLoading = true;
        var registerResponse = await AllApiOperations.createATransfer(
            account_bank: _account_bank,
            account_number: _account_number,
            amount: _amount,
            narration: _narration,
            currency: 'NGN',
            reference: "akhlm-pstmnpyt-rfxx007_PMCKDU_1",
            callback_url:
                "https://webhook.site/b3e505b0-fe02-430e-a538-22bbbce8ce0d",
            debit_currency: "NGN");
        Navigation.previous(context);
        // print(registerResponse['resposeCode']);
        // // ignore: avoid_print
        // print("Weisle register Response is $registerResponse");
        if (registerResponse['status'] == 'success') {
          setLoading = false;
          print('Request Successful');

          Alerts.successAlert(context, 'Transfer successful', () {
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

  CreateTransferProvider() {
    checkFormValidity();
  }
}
