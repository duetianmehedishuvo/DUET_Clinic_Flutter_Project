import 'package:clinico/model/user.dart';
import 'package:clinico/pages/wrapper.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/services/testProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(MultiProvider(providers: [
  //   Provider<TestProvider>(create: (_) => TestProvider()),
  // ], child: MyApp()));
  //
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
        value: AuthServices().user,
        initialData: MyUser(),
        catchError: (_, __) => MyUser(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const Wrapper(),
        ));
  }
// This widget is the root of your application.
// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Flutter Demo',
//     theme: ThemeData(
//       primarySwatch: Colors.indigo,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//     ),
//     home: const Wrapper(),
//   );
// }
}