import 'package:awesome_notes/Pages/recover_password.dart';
import 'package:awesome_notes/change_notifier/registration_controller.dart';
import 'package:awesome_notes/components/note_button.dart';
import 'package:awesome_notes/components/note_form_filed.dart';
import 'package:awesome_notes/components/note_outlined_button.dart';
import 'package:awesome_notes/utils/constants.dart';
import 'package:awesome_notes/utils/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RegistrstionPage extends StatefulWidget {
  const RegistrstionPage({super.key});

  @override
  State<RegistrstionPage> createState() => _RegistrstionPageState();
}

class _RegistrstionPageState extends State<RegistrstionPage> {
  late final RegistrationController registrationController;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formkey;
  // late final bool isVisible;
  // void isObscure(){
  //   setState(() {
  //     isVisible= !isVisible;
  //   });
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registrationController=context.read();
    nameController=TextEditingController();
    emailController=TextEditingController();
    passwordController=TextEditingController();
    formkey=GlobalKey<FormState>();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //registrationController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Selector<RegistrationController,bool>(
                selector: (context,controller)=>controller.isRegisterMode,
                builder:(context,isRegisterMode,child)=> Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                          isRegisterMode?"Register":'Sign in',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 48,
                          fontFamily: 'Fredoka',
                          color: primary
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16,),
                      Text(
                          "In order to sync your data to cloud,you have to register/sign in to the app",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 48,),
                      if(isRegisterMode)...[
                      NoteFormWidget(
                        controller: nameController,
                        labelText: 'Full name',
                        filled: true,
                        fillcolor: white,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        validator: Validator.nameValidator,
                        onChanged: (newValue){
                          registrationController.fullName=newValue;
                        },

                      ),
                      SizedBox(height: 8,),],
                      NoteFormWidget(
                        controller: emailController,
                        labelText: 'Email address',
                        filled: true,
                        fillcolor: white,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validator.mailValidator,
                        onChanged: (newValue){
                          registrationController.email=newValue;
                        },
                      ),
                      SizedBox(height: 8,),
                      Selector<RegistrationController,bool>(
                        selector: (_,controller)=>controller.isPasswordHidden,
                        builder:(context,isPasswordHidden,child)=> NoteFormWidget(
                          controller: passwordController,
                          labelText: 'Password',
                          filled: true,
                          fillcolor: white,
                          isObscure: isPasswordHidden,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              registrationController.isPasswordHidden=!isPasswordHidden;

                            },
                            child: Icon(
                                isPasswordHidden?FontAwesomeIcons.eye:FontAwesomeIcons.eyeSlash
                            ),
                          ),
                          validator: Validator.passwordValidator,
                          onChanged: (newValue){
                            registrationController.password=newValue;
                          },
                        ),
                      ),
                      SizedBox(height: 12,),
                      if(!isRegisterMode)...[
                        GestureDetector(
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PasswordRecovery()));
                          },
                        ),
                        
                        SizedBox(height: 24,)
                      ],
                      SizedBox(
                        height: 48,
                          child: Selector<RegistrationController,bool>(
                            selector: (_,controller)=>controller.isLoading,
                            builder:(_,isLoading,__)=> NoteButton(
                                onPressed: isLoading?null: (){
                                  if(formkey.currentState?.validate()?? false){
                                    registrationController.authenticateWithEmailandPassword(context: context);

                                  }

                                },
                                child: isLoading?SizedBox(
                                  height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: white,

                                    )
                                )
                                :Text( isRegisterMode?'Create my account':'Log me in')
                            ),
                          )
                      ),
                      SizedBox(height: 32,),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text("Or Register With"),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 32,),
                      Row(
                        children: [
                          Expanded(
                            child: NoteIconButtonOutlined(
                                onPressed: (){
                                  registrationController.authenticateWithGoogle(context: context);
                                },
                                icon: FontAwesomeIcons.google
                            ),
                          ),
                          SizedBox(width: 16.0,),
                          Expanded(
                            child: NoteIconButtonOutlined(
                                icon: FontAwesomeIcons.facebook,
                                onPressed: (){}
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 32.0,),
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: isRegisterMode?'Already have an account?':"Don't have an account?",
                          style: TextStyle(
                            color: grey700
                          ),
                          children: [
                            TextSpan(
                              text: isRegisterMode?'Sign in':'Register',
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold
                              ),
                              recognizer: TapGestureRecognizer()..onTap=(){
                                context.read<RegistrationController>().isRegisterMode= !isRegisterMode;

                              }
                            )
                          ]
                        )
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
