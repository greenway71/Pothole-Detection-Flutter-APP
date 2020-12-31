import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Directory/signin.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Container buildTitle(ThemeData theme) {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.bottomCenter,
      child: Text('SIGNUP',style: TextStyle(fontSize: 18,color: theme.primaryColorDark),
      ),
    );
  }
  String _email,_password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(

        appBar: AppBar(
        title: Text("Pothole Detection System"),
        ),
        body: Form(
          key: _formkey,
          child:ListView(
            padding: const EdgeInsets.fromLTRB(16.0,kToolbarHeight,16.0,16.0),
            children: <Widget>[
              Align(
                child:SizedBox(
                    width: 320.0,
                    child:Card(
                      color: theme.primaryColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildTitle(theme),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: TextFormField(
                              validator: (input){
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(input))
                                  return 'Enter Valid Email';
                                else
                                  return null;
                              },
                              onSaved: (input)=>_email=input,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'your@email.com',
                                hintStyle: TextStyle(color: theme.primaryColorDark),
                              ),
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: TextFormField(
                              validator: (input){
                                if (input.length<8)
                                  return 'Password should be of at least 8 characters';
                                else
                                  return null;
                              },
                              onSaved: (input)=>_password=input,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: '',
                                hintStyle: TextStyle(color: theme.primaryColorDark),
                              ),
                              obscureText: true,

                            ),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          Builder(builder: (context)=>RaisedButton(
                            onPressed: () async {
                              final formState=_formkey.currentState;
                              if(_formkey.currentState.validate()){
                                //TODO Login in firebase
                                formState.save();
                                try{
                                  AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:_email,password:_password);
                                  FirebaseUser user = result.user;
                                  user.sendEmailVerification();
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>LoginPage()));
                                }
                                catch(error){
                                  print(error.message);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(error.message),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.deepOrange,
                                  ));
                                }
                              }},
                            child: Text('Sign in'),
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            color: theme.buttonColor,
                          ),) ,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('By Signing up you agree with our terms and conditions.'
                              ,style: TextStyle(color: theme.primaryColorDark),),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                        ],
                      ),
                    )
                ),
              ),

            ],

          ),
        )
    );
  }
}
