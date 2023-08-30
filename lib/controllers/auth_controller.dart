import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empower_u/views/screens/community/home_screen.dart';
import 'package:empower_u/views/screens/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../views/constants/firebase_constants.dart';

class AuthController extends GetxController{

  //text controllers
  var usernameController=TextEditingController();
  var phoneController=TextEditingController();
  var otpController=List.generate(6, (index) => TextEditingController());

  //variables
  var isOtpSent=false.obs;
  var formKey=GlobalKey<FormState>();

  //auth variables
  late final PhoneVerificationCompleted phoneVerificationCompleted;
  late final PhoneVerificationFailed phoneVerificationFailed;
  late PhoneCodeSent phoneCodeSent;
  String verificationID="";
  //sendOtp method
  sendOtp() async
  {
    phoneVerificationCompleted=(PhoneAuthCredential credential)async{
      await auth.signInWithCredential(credential);
    };
    phoneVerificationFailed=(FirebaseAuthException e){
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }

    };
    phoneCodeSent= (String verificationId, int? resendToken){
      verificationID=verificationId;

    };
    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phoneController.text}',
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent:phoneCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
    catch(e)
    {
        print(e.toString());
    }
  }


  verifyOtp(context)async{
    String otp='';
    for( var i=0;i< otpController.length;i++)
    {
      otp+= otpController[i].text;
    }
    try{
         PhoneAuthCredential phoneAuthCredential=
        PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otp);

         //getting user
         final User? user =(await auth.signInWithCredential(phoneAuthCredential)).user;
         if(user!=null)
         {
            //store user into database
           DocumentReference store= FirebaseFirestore
               .instance
               .collection(collectionUser)
               .doc(user.uid);
           await store.set({
             'id':user.uid,
             'name':usernameController.text,
             'phone':phoneController.text,
           },SetOptions(merge: true));

           VxToast.show(context, msg:"Logged in");
           Get.offAll(()=> HomeScreen(username:usernameController.text ,),transition: Transition.downToUp);
         }
    }catch(e)
    {
        VxToast.show(context, msg: e.toString());
    }
  }
}