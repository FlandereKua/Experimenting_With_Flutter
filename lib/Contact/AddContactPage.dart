import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:HelpingHand/Widget/CustomWidget.dart';
import 'package:go_router/go_router.dart';
import 'package:alan_voice/alan_voice.dart';
import '../Services/database.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _EditProfileState();
}

class _EditProfileState extends State<AddContact> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  _EditProfileState() {
    /// Khởi tạo Alan Button với project key từ Alan AI Studio
    AlanVoice.addButton(
        "533730c687eb4dc945998a3232afc7b42e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Xử lý các lệnh từ Alan AI Studio
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }

  void _handleCommand(Map<String, dynamic> command) {
    switch (command["command"]) {
      case "getName":
        nameController.text = command["text"];
        break;
      case "getPhone":
        phoneController.text = command["text"];
        break;
      default:
        debugPrint("Unknown command");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: const Color(0xFF1B1E69),
          title: Row(
            children: [
              InkWell(
                  onTap: () {
                    context.goNamed("AddContact");
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/return.png',
                    width: 30,
                    height: 30,
                  )),
              const SizedBox(
                width: 20,
              ),
              const Text(
                'Edit profile',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.blue, // Màu nền của hình tròn
                      border: Border.all(
                        color: Colors.transparent, // Màu viền
                        width: 5, // Độ rộng của viền
                      ),
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.pinkAccent],
                        // Màu của viền
                        begin: Alignment.topLeft,
                        // Điểm bắt đầu của gradient
                        end:
                        Alignment.bottomRight, // Điểm kết thúc của gradient
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 70, // Bán kính của avatar
                      backgroundImage: AssetImage(
                        'assets/meme-ech-xanh-25.jpg',
                      ), // Đường dẫn ảnh avatar
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "My profile",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B1E69),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'Phone Number',
                    controller: phoneController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomElevatedButton(
                      onPressed: () async {
                        await DataBaseService(uid: _auth.currentUser!.uid)
                            .updateAcquaintances(phoneController.text, nameController.text);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
