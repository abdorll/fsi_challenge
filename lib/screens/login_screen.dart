import 'package:flutter/material.dart';
import 'package:fsi_app/helpers/Alerts.dart';
import 'package:fsi_app/screens/home_page.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordIsVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<LoginProvider>(builder: (context, value, child) {
        return (SideSpace(
          15,
          30,
          SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                    child: IconOf(Icons.class__rounded, orange, 60),
                    radius: 40,
                    backgroundColor: Colors.grey.shade200),
                YSpace(20),
                TextOf("Login", 30, FontWeight.w900, Colors.grey.shade400),
                YSpace(35),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextOf("Email", 20, FontWeight.w500, Colors.grey.shade400),
                    TextFormField(
                      onChanged: (String text) => value.setEmail = text,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "email@fsi.com",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: blue, width: 1))),
                    )
                  ],
                ),
                YSpace(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextOf(
                        "Password", 20, FontWeight.w500, Colors.grey.shade400),
                    TextFormField(
                      onChanged: (String text) => value.setPasword = text,
                      //validator: ,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: passwordIsVisible,
                      decoration: InputDecoration(
                          hintText: "sandbox",
                          suffixIcon: TextButton(
                              onPressed: () {
                                setState(() {
                                  passwordIsVisible = !passwordIsVisible;
                                });
                              },
                              child: passwordIsVisible
                                  ? TextOf('SHOW', 20, FontWeight.w500,
                                      Colors.red.shade200)
                                  : TextOf('HIDE', 20, FontWeight.w500, blue)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: blue, width: 1))),
                    )
                  ],
                ),
                YSpace(10),
                InkWell(
                    onTap: () {
                      value.login(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: white, width: 2),
                          color: orange,
                          borderRadius: BorderRadius.circular(13)),
                      child: Center(
                        child: SideSpace(30, 15,
                            TextOf("Login", 20, FontWeight.w800, white)),
                      ),
                    )),
                YSpace(5),
              ],
            ),
          ),
        ));
      })),
    );
  }
}

//-------------------------LOGIN PROVIDER

class LoginProvider extends BaseProvider {
  String? _email;
  String? _password;
  String? TOKEN;
  bool formValidity = false;

  String get email => _email ?? "";
  String get password => _password ?? '';

  set setEmail(String email) {
    _email = email;
    checkFormValidity();
    notifyListeners();
  }

  set setPasword(String password) {
    _password = password;
    checkFormValidity();
    notifyListeners();
  }

  void checkFormValidity() {
    if ((_email != null) &&
        (_password != null) &&
        (_email!.contains('@')) &&
        (_password!.length > 3)) {
      formValidity = true;
    } else {
      formValidity = false;
    }
    notifyListeners();
  }

  void login(BuildContext context) async {
    try {
      if (_email == null || _password == null) {
        Alerts.responseAlert(context, "All fields are required", () {
          Navigator.pop(context);
        });
      } else if (_password!.length < 3) {
        Alerts.responseAlert(context, "Password length too short", () {
          Navigator.pop(context);
        });
      } else {
        Alerts.loadingAlert(context, "Login in progress...");
        Future.delayed(const Duration(seconds: 5), () async {
          Navigation.previous(context);
          if (email != 'email@fsi.com' && password != 'sandbox') {
            await Alerts.errorAlert(context, 'Invalid login credentials', () {
              Navigation.previous(context);
            });
          } else {
            print('Login successful');
            Navigation.withNoReturn(context, const HomePage());
          }
        });

        // FocusScope.of(context).unfocus();
        // setLoading = true;
        // var loginResponse =
        //     await AuthBasics.login(email: _email, password: _password);
        // print("Muslim Login Response is $loginResponse");
        // Navigation.previous(context);
        // if (loginResponse['status'] == true) {
        //   var tokenBox = await Hive.openBox(TOKEN_BOX);
        //   tokenBox.put(TOKEN_KEY, loginResponse['data']["token"]);
        //   Alerts.successAlert(context, "Login successful", () {
        //     ForwardNavigation.withNoReturn(context, HomeIndex());
        //   });
        // } else if (loginResponse == null) {
        //   Alerts.errorAlert(context, 'Internet connection error', () {
        //     Navigator.pop(context);
        //   });
        // } else {
        //   print("Muslim Login Response is $loginResponse");
        // }
      }
    } catch (e) {
      print("FSI error: $e");
      Navigation.previous(context);
      Alerts.errorAlert(context, 'Error, please try again ', () {
        Navigator.pop(context);
      });
    }
  }

  LoginProvider() {
    checkFormValidity();
  }
}
