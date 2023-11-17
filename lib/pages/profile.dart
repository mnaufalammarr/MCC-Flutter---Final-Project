import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/profilemodel.dart';
import '../provider/profileprovider.dart';
import '../style.dart';
import '../widgets/custombutton.dart';
import '../widgets/customtextfield.dart';
import '../widgets/imageutils.dart';
import '../widgets/menu.dart';

class ProfilePage extends StatefulWidget {
  final String viewType;
  final Profile profile;

  const ProfilePage({Key? key, required this.viewType, required this.profile})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = GlobalKey<FormState>();
  late ProfileProvider profileProvider;
  File? profilepicture;

  DateTime? _selectedDate;
  String? _jenisKelamin;
  bool _passwordconfirmed = true;
  bool _obsecuretext = true;
  bool _obsecuretext1 = true;
  bool _obsecuretext2 = true;
  bool _isPassword8c = true;
  bool get isPassword8c => _isPassword8c;
  bool _isPasswordcapital = true;
  bool get isPasswordcapital => _isPasswordcapital;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _tanggalLahir = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _oldpassword = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();
  final TextEditingController _confirmnewpassword = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickDate != null && pickDate != _tanggalLahir) {
      final formattedDate = DateFormat("yyyy-MM-dd").format(pickDate);
      setState(() {
        _tanggalLahir.text = formattedDate;
      });
    }
  }

  void checkPassword(String password) {
    // Implement your password strength criteria here
    // For example, check length, uppercase letters, digits, special characters, etc.
    bool isPassword8c = password.length >= 8;
    bool isPasswordcapital = password.contains(RegExp(r'[A-Z]'));
    _isPassword8c = isPassword8c;
    _isPasswordcapital = isPasswordcapital;
  }

  @override
  void initState() {
    profileProvider = ProfileProvider();
    getAccountSession();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getAccountSession() {
    Future.delayed(Duration.zero, () async {
      /*
      _profile = profile.fromSession(await Session.get(Session.ACCOUNT_SESSION_KEY));
      if(_profile == null){
        _profile = new profile();
      }
      */
      _name.text = widget.profile!.name!;
      _username.text = widget.profile!.username!;
      _email.text = widget.profile!.email!;
      _alamat.text = widget.profile!.alamat!;
      _jenisKelamin = widget.profile?.jenisKelamin;
      // profilePicture = profile?.profilePicture;
      _tanggalLahir.text = widget.profile!.tanggalLahir!;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> child = [];
    if (widget.viewType == 'datapribadi') {
      child = datapribadi();
    } else if (widget.viewType == 'dataAkun') {
      child = dataakun();
    } else if (widget.viewType == 'suscribe') {
      child = Suscribe();
    }

    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/metrodata.png",
          width: 150,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.closeEndDrawer();
                //close drawer, if drawer is open
              } else {
                scaffoldKey.currentState!.openEndDrawer();
                //open drawer, if drawer is closed
              }
            },
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            color: Styles.black,
          )
        ],
      ),
      endDrawer: Menu(),
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
              padding: EdgeInsets.only(
                  top: 100, left: size.width * 0.05, right: size.width * 0.05),
              children: child),
        ),
      ),
    );
  }

  List<Widget> datapribadi() {
    return <Widget>[
      Center(
        child: Text(
          "Informasi Pribadi",
          style: Styles.HeaderText,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
              minRadius: 30,
              maxRadius: 50,
              child: profilepicture != null
                  // widget.profile!.profilePicture
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          profilepicture!,
                          width:
                              80, // Sesuaikan lebar dan tinggi sesuai kebutuhan
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : YourImageWidget()),
          SizedBox(
            width: 15,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomButton(
                  text: "Ganti Foto",
                  onPressed: () async {
                    await ImageUtils.pickImage(context, (File selectedImage) {
                      // Handle the selected image
                      setState(() {
                        profilepicture = selectedImage;
                      });
                    });
                  },
                ),
                Text(
                  "JPG, GIF or PNG. 1MB max.",
                  style: Styles.detailTextStyle,
                )
              ])
        ],
      ),
      SizedBox(
        height: 20,
      ),
      CustomTextFieldWidget(
        hint: "Nama",
        controller: _name,
        label: "Nama Lengkap",
        textInputType: TextInputType.number,
      ),
      SizedBox(
        height: 20,
      ),
      CustomTextFieldWidget(
        controller: _username,
        label: "Username",
        hint: 'Username',
      ),
      SizedBox(
        height: 20,
      ),
      CustomTextFieldWidget(
        controller: _email,
        label: "Email",
        hint: 'Email',
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Expanded(
            child: CustomTextFieldWidget(
              hint: "DD/MM/YYYY",
              controller: _tanggalLahir,
              readonly: true,
              label: "Tanggal Lahir",
              suffix: IconButton(
                  icon: Icon(Icons.calendar_today),
                  color: Styles.black,
                  onPressed: () => _selectDate(context)),
            ),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                      text: TextSpan(style: Styles.Text16, children: <TextSpan>[
                    TextSpan(text: "Gender "),
                    TextSpan(text: "*", style: TextStyle(color: Styles.red))
                  ])),
                  DropdownButtonFormField<String>(
                    value: _jenisKelamin,
                    onChanged: (String? newValue) {
                      setState(() {
                        _jenisKelamin = newValue;
                      });
                    },
                    items: <String>['Laki-laki', 'Perempuan', 'Lainnya']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Pilih',
                        hintStyle: Styles.inputTextHintDefaultTextStyle,
                        filled: true,
                        fillColor: Styles.inputTextDefaultBackgroundColor),
                    style: Styles.inputTextDefaultTextStyle,
                  ),
                ]),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      CustomTextFieldWidget(
        controller: _alamat,
        label: "Alamat",
        hint: 'Masukan Alamat',
        maxLines: 7,
      ),
      SizedBox(
        height: 20,
      ),
      CustomButton(
          text: "Simpan",
          onPressed: () {
            onUpdateProfile(context);
          })
    ];
  }

  List<Widget> dataakun() {
    return <Widget>[
      Center(
        child: Text(
          "Password",
          style: Styles.HeaderText,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextFieldWidget(
            hint: "Password Lama",
            controller: _oldpassword,
            textInputType: TextInputType.visiblePassword,
            label: "Password Lama",
            pass: _obsecuretext,
            suffix: IconButton(
              icon: Icon(Icons.visibility),
              color: Styles.lightgrey,
              onPressed: () {
                setState(() {
                  _obsecuretext = !_obsecuretext;
                });
              },
            ),
          ),
          CustomTextFieldWidget(
            hint: "Password Baru",
            controller: _newpassword,
            textInputType: TextInputType.visiblePassword,
            label: "Password Baru",
            pass: _obsecuretext1,
            onChanged: (_newpassword) => setState(() {
              checkPassword(_newpassword);
            }),
            suffix: IconButton(
              icon: Icon(Icons.visibility),
              color: Styles.lightgrey,
              onPressed: () {
                setState(() {
                  _obsecuretext1 = !_obsecuretext1;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isPassword8c == false)
                // Show error message if password is not valid
                Expanded(
                  child: RichText(
                      text: TextSpan(style: Styles.Text16, children: <TextSpan>[
                    TextSpan(
                        text: "* ",
                        style: TextStyle(color: Styles.red, fontSize: 10)),
                    TextSpan(
                        text: "Panjang Minimal 8 Character",
                        style: Styles.detailTextStyle),
                  ])),
                ),
              if (isPasswordcapital ==
                  false) // Show error message if password is not valid
                Expanded(
                  child: RichText(
                      text: TextSpan(style: Styles.Text16, children: <TextSpan>[
                    TextSpan(
                        text: "* ",
                        style: TextStyle(color: Styles.red, fontSize: 10)),
                    TextSpan(
                        text: "Mengandung minimal 1 huruf kapital",
                        style: Styles.detailTextStyle),
                  ])),
                ),
            ],
          ),
          if (isPassword8c == false || isPasswordcapital == false)
            SizedBox(
              height: 25,
            )
        ],
      ),
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextFieldWidget(
              hint: "Password",
              controller: _confirmnewpassword,
              textInputType: TextInputType.visiblePassword,
              label: "Password",
              pass: _obsecuretext2,
              onChanged: (_confirmnewpassword) => setState(() {
                if (_newpassword.text != _confirmnewpassword) {
                  _passwordconfirmed = false;
                }
                if (_newpassword.text == _confirmnewpassword) {
                  _passwordconfirmed = true;
                }
              }),
              suffix: IconButton(
                icon: Icon(Icons.visibility),
                color: Styles.lightgrey,
                onPressed: () {
                  setState(() {
                    _obsecuretext2 = !_obsecuretext2;
                  });
                },
              ),
            ),
            if (_passwordconfirmed ==
                false) // Show error message if password is not valid
              RichText(
                  text: TextSpan(style: Styles.Text16, children: <TextSpan>[
                TextSpan(
                    text: "* ",
                    style: TextStyle(color: Styles.red, fontSize: 10)),
                TextSpan(
                    text: "Password tidak sama", style: Styles.detailTextStyle),
              ])),
          ]),
      CustomButton(text: "Simpan", onPressed: () {}),
    ];
  }

  List<Widget> Suscribe() {
    return <Widget>[
      Center(
        child: Text(
          "Email Langganan",
          style: Styles.HeaderText,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "Disini kamu bisa mengatur Email Langganan yang ingin kamu terima sesuai dengan keinginanmu, Metrodata Academy akan mengirimkan email secara berkala yang berisikan promo, wawasan, dan lainnya. Klik produk dibawah ini untuk menerima email langganan :",
        style: Styles.detailTextStyle,
      ),
      SizedBox(
        height: 20,
      ),
      CustomButton(
          text: "Simpan",
          onPressed: () {
            onUpdateProfile(context);
          }),
    ];
  }

  Future<dynamic> onGetProfile(BuildContext context) async {
    dynamic result = await profileProvider.getprofile();
    if (result != null && result['message'] == "Success") {
      return result["data"];
    } else {
      print("error123");
    }
  }

  onUpdateProfile(BuildContext context) async {
    print("object");

    dynamic resultupload =
        await profileProvider.uploadprofileimage(profilepicture!);
    print(resultupload["data"]);
    dynamic resultcreate = await profileProvider.updateprofile(
        _email.text,
        _username.text,
        _jenisKelamin!,
        _alamat.text,
        _tanggalLahir.text,
        _name.text,
        resultupload["data"]);
    if (resultcreate != null && resultcreate['message'] == "Success") {
      Navigator.pop(context);
    } else {
      print("error123");
    }
  }

  Widget YourImageWidget() {
    // Ganti 'imageUrl' dengan variabel yang berisi URL gambar Anda
    String? imageUrl = widget.profile!.profilePicture;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      // Jika imageUrl tidak null dan tidak kosong, tampilkan gambar
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else {
      // Jika imageUrl null atau kosong, tampilkan Icon person
      return Icon(
        Icons.person,
        size: 50,
      );
    }
  }
}
