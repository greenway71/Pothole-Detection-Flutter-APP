import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_project/Pages/maplocation.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser user;

class _LoginPageState extends State<LoginPage> {
  Container buildTitle(ThemeData theme) {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.bottomCenter,
      child: Text('SIGNIN',style: TextStyle(fontSize: 18,color: theme.primaryColorDark),
      ),
    );
  }
  String email,_password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
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
                            key:Key('email-field'),
                            validator: (input){
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(input))
                                return 'Enter Valid Email';
                              else
                                return null;
                            },
                            onSaved: (input)=>email=input,
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
                            key:Key('password-field'),
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
                               AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: _password);
                               user = result.user;
                               Navigator.push(context,MaterialPageRoute(builder: (context)=>MyMap()));
                             }
                             catch(error){
                               print(error.message);
                               Scaffold.of(context).showSnackBar(SnackBar(
                                 content: Text('Something Went Wrong'),
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
                        // SizedBox(
                        //   width: 250,
                        //   child: RaisedButton(
                        //     onPressed: () async {
                        //           final formState=_formkey.currentState;
                        //           if(_formkey.currentState.validate()){
                        //                   //TODO Login in firebase
                        //                   formState.save();
                        //                   try{
                        //                     AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: _password);
                        //                     FirebaseUser user = result.user;
                        //                     Navigator.push(context,MaterialPageRoute(builder: (context)=>MyMap()));
                        //                   }
                        //                   catch(error){
                        //                     print(error.message);
                        //                     final snackBar = SnackBar(
                        //                       content: Text(error.message),
                        //                       action: SnackBarAction(
                        //                         label: 'Undo',
                        //                         onPressed: () {
                        //                           // Some code to undo the change.
                        //                         },
                        //                       ),
                        //                     );
                        //
                        //                     _key.currentState.showSnackBar(snackBar);
                        //                   }
                        //     }},
                        //     child: Text('Sign in'),
                        //     padding: const EdgeInsets.symmetric(vertical: 12.0),
                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        //     color: theme.buttonColor,
                        //   ),
                        // ),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Text('By Signing up you agree with our terms and conditions.'
//                            ,style: TextStyle(color: theme.primaryColorDark),),
//                        ),
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

  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      if (user != null) {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>MyMap()));
      }
    });
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  }


