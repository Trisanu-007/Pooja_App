import 'package:durga_pooja/database_services/user_database.dart';
import 'package:durga_pooja/router.dart';
import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'login_register/switcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Authenticate>(
     create: (context) => Authenticate(),
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       home: Router(),
     ),
    );
  }
}


// class ChangeRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<CurrentUser>.value(
//       value: Authenticate().user,
//       child: MaterialApp(
//         home: Wrapper(),
//       ),
//     );
//   }
// }
//
// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<CurrentUser>(context);
//     if (user == null) {
//       return SwitchScreens();
//     } else {
//       return HomePage();
//     }
//   }
// }
