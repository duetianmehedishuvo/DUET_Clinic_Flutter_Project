import 'package:duet_clinic/pages/signin/signinbutton.dart';
import 'package:duet_clinic/shared/loading.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLoading = false;
  void toggleLoading() {
    setState(() => isLoading = !isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            body: SafeArea(
              child: Container(
                color: Colors.indigo,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .5,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              )),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/signin.png',
                            height: 300,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: Text(
                        "Welcome to duet_clinic!",
                        style:
                            TextStyle(color: Colors.amber[300], fontSize: 40),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: SignButton(
                        name: "Sign in With Google ",
                        toggleLoading: toggleLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
