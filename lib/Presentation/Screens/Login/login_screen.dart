import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Screens/SignUp/signup_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../../Data/Authentication/login.dart';
import '../../Constants/app_assets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

Widget textFieldTitle(String title) {
  return Container(
    alignment: Alignment.topLeft,
    padding: const EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0),
    child: Text(
      title,
      style: const TextStyle(fontSize: formSubtitleFont),
    ),
  );
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      color: containerColor,
                    ),
                    padding: const EdgeInsets.all(0.0),
                    margin: const EdgeInsets.fromLTRB(50.0, 40.0, 50.0, 30.0),
                    child: Image.asset(
                      sosLogoImage,
                      width: size.width / 4,
                      height: size.height / 8,
                    )),
                Container(
                  height: size.height / 1.7,
                  width: size.width / 1.2,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: containerColor,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height / 35,
                        ),
                        const Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: formTitleFont,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        textFieldTitle('Email'),
                        TextFormFieldWidget(
                          hintText: 'email@gmail.com',
                          icon: Icons.email,
                          type: TextInputType.emailAddress,
                          textController: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The email is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        textFieldTitle('Password'),
                        TextFormFieldWidget(
                          hintText: '**********',
                          icon: Icons.lock,
                          type: TextInputType.visiblePassword,
                          textController: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The password is required';
                            }
                            if (value.length < 6) {
                              return 'The password must be greater than 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height / 25,
                        ),
                        MaterialButton(
                            elevation: 6.0,
                            color: primaryColor,
                            padding: EdgeInsets.symmetric(
                                vertical: size.height / 50,
                                horizontal: size.width / 15),
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            onPressed: () {
                              signIn(emailController.text,
                                  passwordController.text, context, formKey);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: white,
                                fontSize: formButtonFont,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return SignUpScreen();
                      }));
                    },
                    child: const Text(
                      "If you don't have an account, SignUp!",
                      style: TextStyle(
                          color: linkColor,
                          fontSize: 18,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
