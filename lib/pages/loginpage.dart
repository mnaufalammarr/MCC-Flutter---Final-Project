import 'package:flutter/material.dart';
import 'package:metrodata_academy/pages/article.dart';
import 'package:metrodata_academy/pages/registerpage.dart';
import 'package:metrodata_academy/style.dart';
import 'package:metrodata_academy/widgets/customtextfield.dart';
import 'package:metrodata_academy/widgets/popupsuccess.dart';

import '../provider/auth.dart';
import '../widgets/custombutton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _ingatsaya = false;
  bool pass = true;
  late AuthProvider _authProvider;

  @override
  void initState() {
    _authProvider = AuthProvider();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(60),
            child: Image.asset("assets/images/metrodata.png"),
            decoration: const BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Color.fromRGBO(113, 157, 233, 0.7), BlendMode.srcOver),
                image: AssetImage("assets/images/bannerbackground.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang",
                    style: Styles.HeaderText,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldWidget(
                          controller: _email,
                          hint: "Masukkan Email",
                          label: "Email"),
                      CustomTextFieldWidget(
                        controller: _password,
                        hint: "Masukkan Password",
                        label: "Password",
                        pass: pass,
                        suffix: IconButton(
                          icon: Icon(
                            pass ? Icons.visibility : Icons.visibility_off,
                            color: Styles.black,
                          ),
                          onPressed: () {
                            setState(() {
                              pass = !pass;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _ingatsaya,
                                onChanged: (value) {
                                  setState(() {
                                    _ingatsaya = value!;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              Text(
                                "Ingat Saya",
                                style: Styles.detailTextStyle,
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Lupa Password?",
                              style: Styles.linkTextStyle,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomButton(
                    text: "Masuk",
                    onPressed: () {
                      setState(() {
                        onLogin(context);
                      });
                    },
                    minimumsize: Size.fromHeight(40)),
                SizedBox(
                  height: 10,
                ),
                Text("Belum punya akun? Daftar disini",
                    style: Styles.detailTextStyle),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    "Daftar Sekarang",
                    style: Styles.linkTextStyle,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ]));
  }

  onLogin(BuildContext context) async {
    dynamic result = await _authProvider.login(
      _email.text,
      _password.text,
    );

    if (result != null && result['message'] == "Success") {
      PopupSuccess.alertDialog(context,
          message: "Berhasil Login",
          submessage: "Klik Ok Untuk Lanjut", onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ArticlePage()));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login Failed"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
