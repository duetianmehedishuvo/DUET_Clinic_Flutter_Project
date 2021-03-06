import 'package:duet_clinic/model/user.dart';
import 'package:duet_clinic/pages/wrapper.dart';
import 'package:duet_clinic/services/auth.dart';
import 'package:duet_clinic/services/testProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // runApp(MultiProvider(providers: [
  //   Provider<TestProvider>(create: (_) => TestProvider()),
  // ], child: MyApp()));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TestProvider()),
    ],
    child: const MyApp(),
  ));


  // runApp(const MyApp());
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
          title: 'DUET Clinic',
          theme: ThemeData(primarySwatch: Colors.teal, visualDensity: VisualDensity.adaptivePlatformDensity),
          home: const Wrapper(),
        ));
  }
}
