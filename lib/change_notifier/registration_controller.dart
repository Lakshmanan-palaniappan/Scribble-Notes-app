import 'package:awesome_notes/services/authService.dart';
import 'package:awesome_notes/utils/constants.dart';
import 'package:awesome_notes/utils/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class RegistrationController extends ChangeNotifier{
  bool _isRegisterMode=true;

  set isRegisterMode(bool value){
    _isRegisterMode=value;
    notifyListeners();
  }
  bool get isRegisterMode=>_isRegisterMode;
  bool _isPasswordHidden=true;
  bool get isPasswordHidden=>_isPasswordHidden;
  set isPasswordHidden(bool value){
    _isPasswordHidden=value;
    notifyListeners();
  }
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  set isLoading(bool value){
    _isLoading=value;
    notifyListeners();
  }
  String _fullName='';
  set fullName(String value){
    _fullName=value;
    notifyListeners();
  }
  String get fullName=>_fullName;
  String _email='';
  set email(String value){
    _email=value;
    notifyListeners();
  }
  String get email=>_email;
  String _password='';
  set password(String value){
    _password=value;
    notifyListeners();
  }
  String get password=>_password;
  Future<void> authenticateWithEmailandPassword ({
    required BuildContext context
    }
      ) async{
    isLoading=true;
    try{
      if(isRegisterMode) {
        await AuthService.register(
            fullName: fullName,
            email: email,
            password: password);
        if(!context.mounted) return;
        showMessageDialog(context: context, message: 'A verification mail has been sent to the provided mail');
        while(!AuthService.isemailVerified){
          await Future.delayed(Duration(seconds: 5),()=>AuthService.user?.reload());

        }
      }else{
        await AuthService.login(email: email, password: password);

      }
    }
    on FirebaseAuthException catch(e){
      if(!context.mounted) return;
      showMessageDialog(
          context: context,
          message: authExceptionMap[e.code] ?? 'An unknown error occurred!'
      );
      isLoading=false;

    }catch(e){
      if(!context.mounted) return;
      showMessageDialog(
          context: context,
          message: 'An unknown error occurred!'
      );
      isLoading=false;

    }finally{
      isLoading=false;
    }

  }
  Future<void> resetPassword({required BuildContext context,required String email})async{
    isLoading=true;
    try{
      await AuthService.resetPassword(email: email);
      if(!context.mounted) return;
      showMessageDialog(context: context,
          message:'A password reset link has been sent to $email. open the link to reset the password'
      );

    }on FirebaseAuthException catch(e){
      if(!context.mounted) return;
      showMessageDialog(
          context: context,
          message: authExceptionMap[e.code] ?? 'An unknown error occurred!'
      );
      isLoading=false;

    }catch(e){
      if(!context.mounted) return;
      showMessageDialog(
          context: context,
          message: 'An unknown error occurred!'
      );
      isLoading=false;

    }finally{
      isLoading=false;
    }
  }
  Future<void> authenticateWithGoogle({required BuildContext context})async{
   try{
     await AuthService.signInWithGoogle();
   }on NoGoogleAccountChosenException{
     return;
   }catch(e){
     if(!context.mounted) return;
     showMessageDialog(context: context, message: 'An unknown error occurred!');
   }

  }
}

class NoGoogleAccountChosenException implements Exception{
  const NoGoogleAccountChosenException();
}