import 'package:flutter/material.dart';
import 'package:pinterest_2022/pages/first_page.dart';
import 'package:pinterest_2022/services/hive_db.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSurname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: size.height * 0.353,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/sign.png"),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Theme.of(context).primaryColor,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                const Text(
                  "Welcome to Pinterest",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      _textField(text: "Name", controller: controllerName),
                      _textField(
                          text: "Surname", controller: controllerSurname),
                      const  SizedBox(height: 20),
                      _buttons(text: "Start"),
                    ],
                  ),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Theme.of(context).hoverColor),
                    text: "The program was created by ",
                    children: const [
                      TextSpan(
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                        text: "J and R",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            _logo(size),
          ],
        ),
      ),
    );
  }

  Container _logo(Size size) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: size.height * 0.49),
      child: Image.asset(
        "assets/images/logo.png",
        height: size.height * 0.2,
      ),
    );
  }

  MaterialButton _buttons({text}) {
    return MaterialButton(
      height: 50,
      minWidth: double.infinity,
      color: Colors.red,
      shape: const StadiumBorder(),
      onPressed: () {
        if (controllerName.text.trim().toString().isNotEmpty ||
            controllerSurname.text.trim().toString().isNotEmpty) {
          Map<String,String> map = {
            "name":controllerName.text.trim().toString(),
            "surname":controllerSurname.text.trim().toString(),
          };
          HiveDB.putUser(map);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const FirstPage()));
        }
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  SizedBox _textField({text, controller}) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        onSubmitted: (value) {},
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
