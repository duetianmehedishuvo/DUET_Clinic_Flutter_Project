import 'package:duet_clinic/services/auth.dart';
import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final String name;
  Function? toggleLoading;
  SignButton({Key? key, this.name='', this.toggleLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();

    return RawMaterialButton(
      shape: const StadiumBorder(),
      onPressed: () {
        toggleLoading!();
        _auth.signInWithGoogle();
      },
      fillColor: Colors.white,
      splashColor: Colors.grey,
      hoverElevation: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
