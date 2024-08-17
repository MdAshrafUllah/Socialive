import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:socialive/presentation/ui/screens/welcome_screen.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/app_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: InkWell(
            onTap: (){
              // todo
            },
            child: const CircleAvatar(
              //radius: 25,
              backgroundImage : NetworkImage(
                //"https://randomuser.me/api/portraits/men/1",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_FHBhip34UKoXlE95hcltUmBiEFWaIUvwSw&s", // todo add user pic
              ),
            ),
          ),
        ),
        title: const Center(child: AppLogo()),
        actions: [
          InkWell(
            onTap: (){
              // todo
            },
            child: CircleAvatar(
              child: SvgPicture.asset(AssetsPath.notification),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: (){
              // todo
            },
            child: CircleAvatar(
              child: SvgPicture.asset(AssetsPath.message),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            child: IconButton(
              onPressed: signUserOut,
              icon: SvgPicture.asset(AssetsPath.logout),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Logged In as: ${user.email!}'),
              // horizontal ListView all users
              // vertical ListView all posts
              // -> by which user, picture, comments

            ],
          ),
        ),
      ),
      //bottomNavigationBar: , // task md Ashraf
    );
  }
  void signUserOut(){
    FirebaseAuth.instance.signOut();
    Get.to(() => const WelComeScreen());
  }
}
