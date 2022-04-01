import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsi_app/helpers/Alerts.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:fsi_app/services/all_apis_calling.dart';
import 'package:provider/provider.dart';

class CreateSavingsPlansPage extends StatefulWidget {
  const CreateSavingsPlansPage({Key? key}) : super(key: key);

  @override
  State<CreateSavingsPlansPage> createState() => _CreateSavingsPlansPageState();
}

class _CreateSavingsPlansPageState extends State<CreateSavingsPlansPage> {
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
          title: TextOf('Create savings plan', 20, FontWeight.w500, black),
        ),
        body: SafeArea(
            child: SideSpace(10, 10, SingleChildScrollView(child:
                Consumer<CreateSavingsProvider>(
                    builder: ((context, value, child) {
          //value.setinterval = SavingsIntervalOptions.interval ?? '';
          return Column(
            children: [
              UserInputField((e) => value.setname = e, 'eg: staff salary',
                  'Name', TextInputType.name),
              UserInputField((e) => value.setamount = e, 'Savings amount',
                  'Amount', TextInputType.number),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     TextOf('Interval', 20, FontWeight.w300, black),
              //   ],
              // ),
              // InkWell(
              //   onTap: () {
              //     chooseIntervalDialogue(context);
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: white,
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border.all(color: ash)),
              //     child: SideSpace(
              //         10,
              //         14,
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             TextOf(
              //                 SavingsIntervalOptions.interval ??
              //                     'Savings period',
              //                 20,
              //                 FontWeight.w300,
              //                 black),
              //             IconOf(Icons.arrow_drop_down_rounded, black, 20)
              //           ],
              //         )),
              //   ),
              // ),
              YSpace(5),
              UserInputField((e) => value.setduration = e,
                  'Savings reoccurrence', 'Duration', TextInputType.number),

              YSpace(10),
              InkWell(
                  onTap: () {
                    print("trying to pay bill");
                    value.save(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: white, width: 2),
                        color: orange,
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: SideSpace(30, 15,
                          TextOf("Start saving", 20, FontWeight.w800, white)),
                    ),
                  )),
            ],
          );
        }))))));
  }

  void chooseIntervalDialogue(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return Container(
            height: 20,
            child: CupertinoAlertDialog(
              title: TextOf('Savings interval', 20, FontWeight.w500, black),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SavingsIntervalOptions('Daily'),
                  SavingsIntervalOptions('Weekly'),
                  SavingsIntervalOptions('Monthly'),
                  SavingsIntervalOptions('Yearly'),
                ],
              ),
            ),
          );
        });
  }
}

class SavingsIntervalOptions extends StatelessWidget {
  SavingsIntervalOptions(
    this.intervalName, {
    Key? key,
  }) : super(key: key);
  String? intervalName;
  static String? interval;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SavingsIntervalOptions.interval = intervalName!;
        Navigation.previous(context);
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: white,
                border: Border.all(color: white),
                borderRadius: BorderRadius.circular(20)),
            child: SideSpace(
              10,
              10,
              TextOfDecoration(
                  intervalName!, 16, FontWeight.w300, black, TextAlign.left),
            ),
          ),
          YSpace(10)
        ],
      ),
    );
  }
}

//----------------------------------------------CREATE SAVINGS PLAN PROVIDER
class CreateSavingsProvider extends BaseProvider {
  String? _name;
  //String? _interval;
  String? _amount;
  String? _duration;
  bool formValidity = false;

  String get name => _name ?? '';
  //String get interval => _interval ?? '';
  String get amount => _amount ?? '';
  String get duration => _duration ?? '';

  set setname(String name) {
    _name = name;
    checkFormValidity();
    notifyListeners();
  }

  // set setinterval(String interval) {
  //   _interval = interval;
  //   checkFormValidity();
  //   notifyListeners();
  // }

  set setamount(String amount) {
    _amount = amount;
    checkFormValidity();
    notifyListeners();
  }

  set setduration(String duration) {
    _duration = duration;
    checkFormValidity();
    notifyListeners();
  }

  void checkFormValidity() {
    if ((_name != null) && (_amount != null) && (_duration != null)) {
      formValidity = true;
    } else {
      formValidity = false;
    }
    notifyListeners();
  }

  void save(BuildContext context) async {
    try {
      if (name == '' || amount == '' || duration == '') {
        Alerts.errorAlert(context, 'All fields are required', () {
          Navigator.pop(context);
        });
      } else {
        Alerts.loadingAlert(context, 'Saving...');

        FocusScope.of(context).unfocus();
        setLoading = true;
        var registerResponse = await AllApiOperations.createSavingsPlan(
          name: _name,
          interval: 'Monthly',
          amount: _amount,
          duration: _duration,
        );
        Navigation.previous(context);
        if (registerResponse['status'] == 'success') {
          setLoading = false;
          print('Request Successful');
          Alerts.successAlert(context, 'Savings successful', () {
            Navigation.previous(context);
          });
        } else {
          setLoading = false;
          Navigation.previous(context);
          Alerts.errorAlert(context, 'Savings failed', () {
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

  CreateSavingsProvider() {
    checkFormValidity();
  }
}
