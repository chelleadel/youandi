import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/confirm_email.dart';
import 'package:test/constants.dart';
import 'package:test/registration.dart';
import 'package:test/welcomepage.dart';
import 'services/firebase.dart';

class Sign_Up extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pass1Controller = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final _formEmailKey = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Constants.BG_BASE,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Back',
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => WelcomePage()));
            },
          ),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: Constants.TITLE_SIZE,
                        fontFamily: Constants.FONT_BASE,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 40),
                  Form(
                      key: _formEmailKey,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if ((value == null) || (value.isEmpty)) {
                                    return "Email can't be empty";
                                  } else if (!(value.contains('@u.nus.edu'))) {
                                    return "NUS Email required";
                                  } else {
                                    return null;
                                  }
                                  },
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                  hintText: 'NUS Email Only (@u.nus.edu)',
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _pass1Controller,
                                validator: (value) {
                                  if ((value == null) || (value.isEmpty)) {
                                    return "Password can't be empty";
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _pass2Controller,
                                validator: (value) {
                                  if ((value == null) || (value.isEmpty)) {
                                    return "Confirm Password can't be empty";
                                  } else if (value != _pass1Controller.text) {
                                    return "Passwords are not the same";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                            ]
                          )
                      )
                  ),

                  SizedBox(height: 45),
                  ElevatedButton(
                      onPressed: () async {
                        print('Email: ' + _emailController.text);
                        if ((_formEmailKey.currentState!.validate())) {

                          try {
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _pass1Controller.text
                            );


                            User? user = FirebaseAuth.instance.currentUser;
                            if (user!= null && !user.emailVerified) {
                              await user.sendEmailVerification();
                            }
                            var currentUser = FirebaseAuth.instance.currentUser;
                            Firebase.ADD_USER_STRING(currentUser!.uid, "Email", _emailController.text);
                            Firebase.UPDATE_USER_INT(currentUser.uid, "NumberOfMatch", 0);
                            Firebase.UPDATE_USER_BOOL(currentUser.uid, "IsUserAlerted", true);
                            Firebase.UPDATE_USER_INT(currentUser.uid, "warningCounter", 0);
                            Firebase.UPDATE_USER_ARRAY(currentUser.uid, "warningArray", [""]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ConfirmEmailPage()),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Password is too weak!"),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('Please use a strong password.'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Account has already been registered"),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('Kindly log in instead.'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );
                              print('The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                        },
                      child: Text('Continue',
                        style: TextStyle(
                          fontSize: Constants.BUTTON_FONT_SIZE,
                          color: Colors.white,
                          fontFamily: Constants.BUTTON_FONT,
                        ),),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Constants.BUTTON_BASE),
                          fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                                //side: BorderSide(color: Colors.black)
                              )
                          )
                      ),
                  ),
                ]
            )
        )
    );

  }


}