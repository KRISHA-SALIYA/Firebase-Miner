import 'package:flutter/material.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:my_chat_app/service/auth_service.dart';
import 'package:my_chat_app/service/fire_service.dart';
import 'package:my_chat_app/utils/app_routes.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade400,
        title: const Text("All User"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.popAndPushNamed(
              context,
              Routes.homepage,
            );
          },
        ),
      ),
      backgroundColor: Colors.yellow.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          builder: (context, snapshot) {
            List<UserModel> allUser = [];
            if (snapshot.hasData) {
              allUser = snapshot.data?.docs
                      .map(
                        (e) => UserModel.fromJson(
                          e.data() as Map<String, dynamic>,
                        ),
                      )
                      .toList() ??
                  [];
            }
            allUser.removeWhere((element) =>
                element.uid == AuthService.instnce.auth.currentUser!.uid);
            return ListView.builder(
              itemCount: allUser.length,
              itemBuilder: (context, index) {
                UserModel user = allUser[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(
                        user.photoUrl ??
                            "https://e7.pngegg.com/pngimages/81/570/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png",
                      ),
                    ),
                    title: Text(user.displayName ?? "Guest"),
                    subtitle: Text(user.email ?? "Undefined"),
                    trailing: IconButton(
                      onPressed: () {
                        FireStoreService.instance.addFriend(userModel: user);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            );
          },
          stream: FireStoreService.instance.getAllUsers(),
        ),
      ),
    );
  }
}
