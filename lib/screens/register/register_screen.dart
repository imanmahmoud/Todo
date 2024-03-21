import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/custom_text_form_field.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/model/user_model.dart';
import 'package:todo/screens/home/home_screen.dart';
import 'package:todo/screens/login/login_screen.dart';

import '../../my_theme.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var userNameController = TextEditingController(text: "eman4");

  var emailController = TextEditingController(text: "eman4@m.com");

  var passwordController = TextEditingController(text: "1111111");

  var confirmationPasswordController = TextEditingController(text: "1111111");

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
                    label: 'User Name',
                    controller: userNameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) return 'please enter user name';
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: 'Email Address',
                    controller: emailController,
                    keyBoard: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) return 'please enter email address';
                      bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if(!emailValid) return "Please enter valid name";
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) return 'please enter password';
                      if (text.length < 6) return 'password should be at least 6 characters';
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: 'confirmation Password',
                    isPassword: true,
                    controller: confirmationPasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) return 'please enter confirmation password';
                      if (text != passwordController.text) return "password doesn't match";
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(onPressed: () {
                      createAccount();
                    },
                        style: ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                          ,
                            padding: EdgeInsets.symmetric( vertical: 10 ),),
                        child: Text("Create Account",style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: MyTheme.whiteColor),)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: Text(
                        'Already have an account',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                            color: MyTheme.blueColor,
                            fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createAccount()async{
    if (formKey.currentState?.validate() == true){
      ///show loading
      DialogUtils.showLoading(context, 'Loading...');

      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var myUser = MyUser(id: credential.user?.uid ??'', name: userNameController.text,email: emailController.text);
        await FirebaseUtils.addUser(myUser);

        ///hide loading
        DialogUtils.hideDialog(context);
        ///show message successfully
        DialogUtils.showMessage(context, 'Register successfully',
        title: "Success",
        posActionName: "Ok",
        posAction: () {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        },);


      } on FirebaseAuthException catch (e) {
        ///hide loading
        DialogUtils.hideDialog(context);

        ///show message error
         String errorMessage="Something went wrong ";

        if (e.code == 'weak-password') {
          errorMessage='The password provided is too weak.';
          DialogUtils.showMessage(context, errorMessage, title: "Error",
            posActionName: "Ok",);
        } else if (e.code == 'email-already-in-use') {
          errorMessage='The account already exists for that email.';
          DialogUtils.showMessage(context, errorMessage, title: "Error",
            posActionName: "Ok",);

        }
      } catch (e) {
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(context, e.toString(), title: "Error",
          posActionName: "Ok",);

      }
    }
  }
}
