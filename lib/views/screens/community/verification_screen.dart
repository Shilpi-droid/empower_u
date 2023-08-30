
import 'package:empower_u/views/screens/community/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/auth_controller.dart';

import '../../constants/strings.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller= Get.put(AuthController());




    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: letsconnect.text.black.bold.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child:Column(
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value)
                      {
                          if(value!.isEmpty || value.length<6)
                            {
                              return "Please enter your username";
                            }
                      },
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Vx.gray400,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Vx.gray400
                              )
                          ),
                          labelText: "Username",
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.phone_android,color: btnColor,),
                          hintText: "eg. 1234567890",
                          labelStyle: const TextStyle(
                              color: Vx.gray600,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      validator: (value)
                      {
                        if(value!.isEmpty || value.length<6)
                        {
                          return "Please enter your Phone Number";
                        }
                      },
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Vx.gray400,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Vx.gray400
                              )
                          ),
                          labelText: "Phone Number",
                          prefixText: "+91",
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.phone_android,color: btnColor,),
                          hintText: "eg. 1234567890",
                          labelStyle: const TextStyle(
                              color: Vx.gray600,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ],
                ),
              ),
              10.heightBox,
              otp.text.semiBold.size(16).make(),
              Obx(()=>
                 Visibility(
                   visible: controller.isOtpSent.value,
                   child: SizedBox(
                    height: 80,
                    width: 390,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                        List.generate(6, (index) => SizedBox(
                          width: 53,
                          child: TextField(
                            controller: controller.otpController[index],
                            cursorColor: btnColor,
                            onChanged: (value){
                              if(value.length ==1 && index<=5)
                                {
                                  Focus.of(context).previousFocus();
                                }
                            },
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: btnColor
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: bgColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: bgColor),
                              ),
                              hintText: "*"
                            ),
                          ),
                        ))

                    ),
                ),
                 ),
              ),

              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: context.screenWidth-80,
                  child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                    onPressed: ()async
                    {
                      if(controller.formKey.currentState!.validate()) {
                        if (controller.isOtpSent.value == false) {
                          controller.isOtpSent.value = true;
                          await controller.sendOtp();
                        } else {
                          await controller.verifyOtp(context);
                        }
                      }
                      // Get.to(()=>HomeScreen(),transition: Transition.downToUp);
                    },
                    child: continueText.text.white.semiBold.size(16).make(),

                )),
              ),
              30.heightBox,
            ],
          )
        ),
      ),
    );
  }
}
