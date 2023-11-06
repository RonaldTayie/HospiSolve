import 'package:flutter/material.dart';

class AuthViewTextField extends StatelessWidget {

  final TextInputType type;
  final String label;
  final Widget icon;
  final Function change;
  final bool isPassword;
  final bool isEnabled;
  const AuthViewTextField({super.key,  required this.type,required this.label,required this.icon, required this.change, this.isPassword = false, this.isEnabled=true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          enabled: isEnabled,
            keyboardType: type,
            obscureText: isPassword,
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(217, 217, 217, 0.5),
              filled: true,
              labelText: label,
              labelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
              prefixIcon : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: icon,
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      style: BorderStyle.solid,
                      width: 2,
                      color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10),)
              ),
            ),
            onChanged: (e)=>change(e)
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
