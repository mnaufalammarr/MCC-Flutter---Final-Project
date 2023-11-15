import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrodata_academy/provider/auth.dart';

import '../style.dart';
import '../widgets/custombutton.dart';
import '../widgets/customtextfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _username = TextEditingController();
  String? _jenisKelamin;
  TextEditingController _tanggalLahir = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  TextEditingController _namalengkap = TextEditingController();
  bool? pass = true;
  bool? passConfirm = true;

  bool _isPassword8c = true;
  bool _isPasswordUpper = true;
  bool? get isPassword8c => _isPassword8c;
  bool get isPasswordUpper => _isPasswordUpper;
  bool _passwordConfirm = true;
  bool _term = false;
  bool _subscribe = false;

  bool? get isRegistrationEnabled =>
      _namalengkap.text.isNotEmpty &&
      _username.text.isNotEmpty &&
      _email.text.isNotEmpty &&
      _tanggalLahir.text.isNotEmpty &&
      _password.text.isNotEmpty &&
      _confirmpassword.text.isNotEmpty &&
      _term &&
      _subscribe &&
      _passwordConfirm &&
      _isPassword8c &&
      _isPasswordUpper;

  late AuthProvider _authProvider;

  @override
  void initState() {
    _authProvider = AuthProvider();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _tanggalLahir.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    _namalengkap.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (pickDate != null && pickDate != _tanggalLahir) {
      final formattedDate = DateFormat("yyyy-MM-dd").format(pickDate);
      setState(() {
        _tanggalLahir.text = formattedDate;
      });
    }
  }

  void checkPassword(String password) {
    bool isPassword8c = password.length >= 8;
    bool isPasswordUpper = password.contains(RegExp(r'[A-Z]'));
    _isPassword8c = isPassword8c;
    _isPasswordUpper = isPasswordUpper;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daftar Akun Baru",
                    style: Styles.HeaderText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldWidget(
                        controller: _namalengkap,
                        hint: "Masukkan Nama Lengkap",
                        label: "Name",
                      ),
                      CustomTextFieldWidget(
                        controller: _username,
                        hint: "Masukkan Username",
                        label: "Username",
                      ),
                      CustomTextFieldWidget(
                        controller: _email,
                        hint: "Masukkan Email",
                        label: "Email",
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWidget(
                              controller: _tanggalLahir,
                              hint: "YYYY-MM-DD",
                              label: "Tanggal Lahir",
                              readonly: true,
                              suffix: IconButton(
                                icon: Icon(Icons.calendar_today),
                                color: Styles.black,
                                onPressed: () {
                                  _selectDate(context);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jenis Kelamin",
                                style: Styles.Text16,
                              ),
                              DropdownButtonFormField<String>(
                                  value: _jenisKelamin,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _jenisKelamin = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Laki-laki',
                                    'Perempuan',
                                    'Lainnya'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    hintText: "Pilih ",
                                    hintStyle:
                                        Styles.inputTextHintDefaultTextStyle,
                                    fillColor:
                                        Styles.inputTextDefaultBackgroundColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: Styles.inputTextDefaultTextStyle)
                            ],
                          ))
                        ],
                      ),
                      CustomTextFieldWidget(
                        controller: _password,
                        hint: "Masukkan Password",
                        label: "Password",
                        pass: pass!,
                        onChanged: (value) {
                          setState(() {
                            checkPassword(value);
                          });
                        },
                        suffix: IconButton(
                          icon: Icon(
                            pass! ? Icons.visibility : Icons.visibility_off,
                            color: Styles.black,
                          ),
                          onPressed: () {
                            setState(() {
                              pass = !pass!;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          if (isPassword8c == false)
                            Expanded(
                              child: RichText(
                                  text:
                                      TextSpan(style: Styles.Text16, children: [
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                        color: Styles.red, fontSize: 10)),
                                TextSpan(
                                    text: "Panjang Minimal 8 Character",
                                    style: Styles.detailTextStyle),
                              ])),
                            ),
                          if (isPasswordUpper == false)
                            Expanded(
                              child: RichText(
                                  text:
                                      TextSpan(style: Styles.Text16, children: [
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                        color: Styles.red, fontSize: 10)),
                                TextSpan(
                                    text: "Mengandung minimal 1 huruf kapital",
                                    style: Styles.detailTextStyle),
                              ])),
                            )
                        ],
                      ),
                      CustomTextFieldWidget(
                        controller: _confirmpassword,
                        hint: "Masukkan Password",
                        label: "Confirm Password",
                        pass: passConfirm,
                        onChanged: (value) {
                          setState(() {
                            if (_password.text != value) {
                              _passwordConfirm = false;
                            } else if (_password.text == value) {
                              _passwordConfirm = true;
                            }
                          });
                        },
                        suffix: IconButton(
                          icon: Icon(
                            passConfirm!
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Styles.black,
                          ),
                          onPressed: () {
                            setState(() {
                              passConfirm = !passConfirm!;
                            });
                          },
                        ),
                      ),
                      if (_passwordConfirm == false)
                        RichText(
                            text: TextSpan(style: Styles.Text16, children: [
                          TextSpan(
                              text: "*",
                              style:
                                  TextStyle(color: Styles.red, fontSize: 10)),
                          TextSpan(
                              text: "Password tidak sama",
                              style: Styles.detailTextStyle),
                        ])),
                      Row(
                        children: [
                          Checkbox(
                            value: _term,
                            onChanged: (value) {
                              setState(() {
                                _term = value!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                          ),
                          Expanded(
                            child: RichText(
                                text: TextSpan(
                                    style: Styles.detailTextStyle,
                                    children: [
                                  TextSpan(
                                      text:
                                          "Dengan mendaftar anda dianggap telah membaca dan menyetujui "),
                                  TextSpan(
                                      text: "Aturan penggunaan dan kebijakan ",
                                      style: Styles.detailLinkTextStyle),
                                  TextSpan(text: "yang berlaku"),
                                ])),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _subscribe,
                            onChanged: (value) {
                              setState(() {
                                _subscribe = value!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                          ),
                          Expanded(
                              child: Text(
                            "Saya ingin menerima email subscribtion pemberitahuan dari metrodata academy.",
                            style: Styles.detailTextStyle,
                          ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    text: "Register",
                    onPressed: () {
                      OnRegister(context);
                    },
                    minimumsize: Size.fromHeight(40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Sudah punya akun? Masuk disini",
                      style: Styles.detailTextStyle),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Masuk Sekarang",
                      style: Styles.linkTextStyle,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  OnRegister(BuildContext context) async {
    if (isRegistrationEnabled!) {
      dynamic result = await _authProvider.register(
          _email.text,
          _username.text,
          _jenisKelamin!,
          _tanggalLahir.text,
          _password.text,
          _namalengkap.text);
      if (result['message'] == "Success") {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration Success"),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration Failed"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all fields"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
