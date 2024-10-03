import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:my_chat_app/service/auth_service.dart';
import 'package:my_chat_app/service/fire_service.dart';
import 'package:my_chat_app/utils/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade400,
        title: Text(AuthService.instnce.auth.currentUser!.email?.split('@')[0]
            as String),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              Routes.signin as Route<Object?>,
              ModalRoute.withName(Routes.signin),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthService.instnce.logOut();
            },
          ),
        ],
      ),
      backgroundColor: Colors.yellow.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: StreamBuilder(
                stream: FireStoreService.instance.getFriendsStream(),
                builder: (context, snapshot) {
                  List<UserModel> allFriend = snapshot.data?.docs
                          .map(
                            (e) => UserModel.fromJson(e.data()),
                          )
                          .toList() ??
                      [];
                  return allFriend.isEmpty
                      ? const Center(
                          child: Text("You don't have any friend"),
                        )
                      : GestureDetector(
                          onLongPress: () {
                            showBottomSheet(
                              context: context,
                              builder: (context) => BottomSheet(
                                onClosing: () {},
                                builder: (context) => Container(
                                  height: 500,
                                  width: 500,
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(),
                                      const CircleAvatar(
                                        backgroundColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ListView.builder(
                            itemCount: allFriend.length,
                            itemBuilder: (context, index) => Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.chatpage,
                                      arguments: allFriend[index]);
                                },
                                leading: CircleAvatar(
                                  foregroundImage: NetworkImage(
                                    allFriend[index].photoUrl ??
                                        "https://e7.pngegg.com/pngimages/81/570/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png",
                                  ),
                                ),
                                title: Text(
                                  allFriend[index].email?.split("@")[0] ??
                                      "Guest",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    FireStoreService.instance.deleteFriend(
                                        userModel: allFriend[index]);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
