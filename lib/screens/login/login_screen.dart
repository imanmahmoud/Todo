import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/custom_text_form_field.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/screens/register/register_screen.dart';

import '../../firebase_utils.dart';
import '../../my_theme.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'eman1@m.com');

  var passwordController = TextEditingController(text: "1111111");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/main_background.png',
              fit: BoxFit.fill, width: double.infinity),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  CustomTextFormField(
                    label: 'Email Address',
                    controller: emailController,
                    keyBoard: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty)
                        return 'please enter email address';
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) return "Please enter valid email";
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty)
                        return 'please enter password';
                      if (text.length < 6)
                        return 'password should be at least 6 characters';
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyTheme.whiteColor),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: Theme.of(context).textTheme.bodyMedium),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(RegisterScreen.routeName);
                          },
                          child: Text(
                            'SignUp',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: MyTheme.blueColor,
                                    fontWeight: FontWeight.w700),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context, 'Loading...');

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        var user =await FirebaseUtils.readUserFromFireStore(credential.user?.uid ??'');

        if(user == null){
          return;
        }

        ///hide loading
        DialogUtils.hideDialog(context);
        ///show message successfully
        DialogUtils.showMessage(context, 'Login successfully',
          title: "Success",
          posActionName: "Ok",
          posAction: () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },);


      } on FirebaseAuthException catch (e) {

        /*if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }*/

        DialogUtils.hideDialog(context);

        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          DialogUtils.showMessage(context, 'Wrong password or No user found for that email.', title: "Error",
            posActionName: "Ok",);
        }
      } catch (e) {
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(context, e.toString(), title: "Error",
          posActionName: "Ok",);
        print("error: ${e.toString()}");
      }
    }
  }
}
