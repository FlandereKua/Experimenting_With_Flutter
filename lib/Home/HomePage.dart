import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:HelpingHand/local_notifications.dart';
import '../Profile/EditProfilePage.dart';
import '../Profile/ProfilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radiusAnimation;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Widget> pages = [const EditProfile(), const Profile()];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _radiusAnimation = Tween(begin: 200.0, end: 3000.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   _controller.forward();
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading");
          }
          var userDocument = snapshot.data;
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80.0),
              child: AppBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w200),
                    ),
                    // SizedBox(height: 10,),
                    Text(
                      userDocument?["Full Name"],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF1B1E69),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  )
                ],
                leading: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/meme.jpg'), // Thay đổi đường dẫn ảnh của bạn ở đây
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                width: 300,
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Đã gửi tín hiệu cầu cứu!",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      backgroundColor: Color(0xFF1B1E69),
                    ));
                    LocalNotifications.showSimpleNotification(
                        title: "Đạt đang gặp nguy hiểm, hãy kệ cmn!",
                        body: "cíu cíu, help me! help me!",
                        payload: "help me!");
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: _radiusAnimation.value,
                        height: _radiusAnimation.value,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFECECEC),
                        ),
                      ),
                      Container(
                        width: _radiusAnimation.value * 0.8,
                        height: _radiusAnimation.value * 0.8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFBCCEE2),
                        ),
                      ),
                      Container(
                        width: _radiusAnimation.value * 0.6,
                        height: _radiusAnimation.value * 0.6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFA4BEDD),
                        ),
                      ),
                      Container(
                        width: _radiusAnimation.value * 0.4,
                        height: _radiusAnimation.value * 0.4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF8CAED8),
                        ),
                      ),
                      Container(
                        width: _radiusAnimation.value * 0.2,
                        height: _radiusAnimation.value * 0.2,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF749FD3),
                        ),
                      ),
                      Container(
                        width: _radiusAnimation.value * 0.1,
                        height: _radiusAnimation.value * 0.1,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF465394),
                        ),
                      ),
                      Image.asset(
                        'assets/bell.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
