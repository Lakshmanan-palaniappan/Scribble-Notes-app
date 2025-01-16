import 'package:awesome_notes/change_notifier/registration_controller.dart';
import 'package:awesome_notes/components/back_button.dart';
import 'package:awesome_notes/components/note_button.dart';
import 'package:awesome_notes/components/note_form_filed.dart';
import 'package:awesome_notes/utils/constants.dart';
import 'package:awesome_notes/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  late final TextEditingController emailController;
  final GlobalKey<FormState> emailKey=GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController=TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: NoteBackButton(),
        title: Text("Recover Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: emailKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    'Don\'t worry! Happens to best of us!',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24,),
                NoteFormWidget(
                  //key: emailKey,
                  controller: emailController,
                  fillcolor: white,
                  filled: true,
                  labelText: 'Email',
                  validator: Validator.mailValidator,
                ),
                SizedBox(height: 24,),
                SizedBox(
                    height:48.0,
                    child: Selector<RegistrationController,bool>(
                      selector: (_,controller)=>controller.isLoading,
                      builder:(_,isLoading,__)=> NoteButton(
                          child: isLoading?
                              SizedBox(
                                width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(color: white,)
                              )
                              :Text(
                              'Send me a recovery link'
                          ),
                          onPressed: isLoading?null: (){
                            if(emailKey.currentState?.validate()??false){
                              context.read<RegistrationController>().resetPassword(context: context, email: emailController.text.trim());
            
            
                            }
            
                          }
                          ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
