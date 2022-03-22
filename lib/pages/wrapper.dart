import 'package:clinico/model/user.dart';
import 'package:clinico/pages/loggedWrapper.dart';
import 'package:clinico/pages/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    if(user.uid.isEmpty){
      return const SignInPage();
    }else{
       return LoggedWrapper(user:user);
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //
  //   return const SignInPage();
  // }
}