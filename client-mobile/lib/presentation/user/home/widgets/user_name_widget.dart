import 'package:cityflat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/token_provider.dart';
import '../../../../services/user_service.dart';

class UserNameWidget extends StatefulWidget {
  @override
  State<UserNameWidget> createState() => _UserNameWidgetState();
}

class _UserNameWidgetState extends State<UserNameWidget> {
  Future<User>? userFuture;

  Future<void> onGetOneUser() async {
    try {
      final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
      await tokenProvider.decodeToken();
      Map<String, dynamic>? token = tokenProvider.decodedToken;

      Future<User>? fetchedUser =
          UserService().getOneUser(token!["user"]["email"]);

      setState(() {
        userFuture = fetchedUser;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: userFuture,
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text("Username ...");
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return const Text("Username");
              }

              if (snapshot.hasData) {
                print(snapshot.data!.name!);
                return Text(snapshot.data!.name!);
              } else {
                return const Text("Username");
              }
          }
        });
  }
}
