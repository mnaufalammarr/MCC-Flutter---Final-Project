import 'package:flutter/material.dart';
import 'package:metrodata_academy/provider/profileprovider.dart';

import '../models/profilemodel.dart';
import '../style.dart';
import '../widgets/menu.dart';
import '../widgets/profilemenulist.dart';

class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({Key? key}) : super(key: key);

  State<ProfileMenuPage> createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ProfileProvider profileProvider;
  Profile? profile;

  @override
  void initState() {
    profileProvider = new ProfileProvider();
    fetchprofile();
    super.initState();
  }

  Future<void> fetchprofile() async {
    try {
      dynamic response = await profileProvider.getprofile();

      if (response != null && response['message'] == 'Success') {
        Map<String, dynamic> profileData = response['data'];
        setState(() {
          print("aaa");
          profile = Profile.fromJson(profileData);
          print("object");
        });
      } else {
        print("Error fetching profile: Invalid response format");
        // Handle error appropriately, e.g., show an error message to the user
      }
    } catch (error) {
      print("Error fetching profile: $error");
      // Handle error appropriately, e.g., show an error message to the user
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return Center(child: CircularProgressIndicator());
    } else {
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
        body: ListView(children: [
          Container(
            color: Color.fromRGBO(241, 245, 253, 1),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: Styles.HeaderText,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CircleAvatar(
                        minRadius: 30, maxRadius: 50, child: YourImageWidget()),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      profile!.name!,
                      style: Styles.Text16,
                    )
                  ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                ProfileMenuList(
                  label: "Data Pribadi",
                  icon: Icons.person,
                  page: 'datapribadi',
                  profile: profile!,
                ),
                ProfileMenuList(
                  label: "Data Akun",
                  icon: Icons.dataset,
                  page: 'dataAkun',
                  profile: profile!,
                ),
                ProfileMenuList(
                  label: "Email Langganan",
                  icon: Icons.mail,
                  page: "suscribe",
                  profile: profile!,
                ),
                ProfileMenuList(
                  label: "keluar",
                  icon: Icons.logout,
                  page: "",
                  profile: profile!,
                ),
              ],
            ),
          ),
        ]),
      );
    }
  }

  Widget YourImageWidget() {
    // Ganti 'imageUrl' dengan variabel yang berisi URL gambar Anda
    String? imageUrl = profile!.profilePicture;

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
