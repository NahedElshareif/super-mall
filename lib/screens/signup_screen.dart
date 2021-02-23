import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supermall/constants.dart';
import 'package:supermall/provider/modelhud.dart';
import 'package:supermall/screens/user/home_screen.dart';
import 'package:supermall/screens/login_screen.dart';
import 'package:supermall/widgets/custom_textField.dart';
import 'package:supermall/widgets/custom_logo.dart';
import 'package:supermall/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';





// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  static String id='signupScreen';
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  String _email,_password;
  final _auth=Auth();

  @override
  Widget build(BuildContext context) {

    double hight=MediaQuery.of(context).size.height;

   return  Scaffold(
        backgroundColor: KMainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
                child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                CustomLogo(),
                SizedBox(
                  height: hight*0.05,
                ),
                CustomTextField(
                  onClick: (value){
                   //_email=value;
                  },
                  hint:'Enter your name',
                  icon: Icons.person),
                SizedBox(
                  height: hight*0.02,
                ),
                CustomTextField(
                  onClick: (value){
                    _email=value;
                  },
                  hint:'Enter your email address',
                  icon: Icons.email),
                SizedBox(
                  height: hight*0.02,
                ),
                CustomTextField(
                  onClick: (value){
                    _password=value;

                  },
                  hint:'Enter your password',
                  icon: Icons.lock),
                SizedBox(
                  height: hight*0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Builder(
                    builder:(context)=> FlatButton(
                      color: KSecondColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        ),
                      child: Text('Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20),
                        ),
                      onPressed: ()async{
                        final modelhud = Provider.of<ModelHud>(context,listen: false);
                        modelhud.ChangeIsLoading(true);

                        if (_globalKey.currentState.validate())
                        {
                          _globalKey.currentState.save();
                          //print(_email);
                          //print(_password);
                          try {
                            // ignore: unused_local_variable
                            final authResult= await _auth.signUp(_email, _password);
                            modelhud.ChangeIsLoading(false);
                            Navigator.pushNamed(context,HomeScreen.id);
                          }  on PlatformException catch (e) {

                          modelhud.ChangeIsLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              e.message
                            ),
                            ));
                          
                          }
                          
                          //print (authResult.user.uid);
                        }
                        modelhud.ChangeIsLoading(false);

                      },),
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do you have an account ? ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,),),
                      GestureDetector(
                         onTap: (){
                           Navigator.pushNamed(context, LoginScreen.id);
                         },
                        child: Text('Login',style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,),
                          ),
                      ),

                    ],

                  ),


              ],
            ),
          ),
        ),
        
      
   );
  }
}