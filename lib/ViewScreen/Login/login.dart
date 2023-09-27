import 'package:chatapp/ViewScreen/Login/resetemail.dart';
import 'package:chatapp/ViewScreen/Login/signup.dart';
import 'package:chatapp/ViewScreen/chatpage.dart';
import 'package:chatapp/widgets/my_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  final Uri _facebookurl = Uri.parse('https://www.facebook.com/');
  final Uri _googleaccounturl = Uri.parse('https://accounts.google.com/ServiceLogin?hl=en-GB');


  Future<void> facebooklaunch() async {
    if (!await launchUrl(_facebookurl)) {
      throw Exception('Could not launch $_facebookurl');
    }
  }

  Future<void> googlelaunch() async {
    if (!await launchUrl(_googleaccounturl)) {
      throw Exception('Could not launch $_googleaccounturl');
    }
  }

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();
  }

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/badal.jpg",
                    ),
                    fit: BoxFit.fill)),
          ),
          Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
                child:

                SingleChildScrollView(child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.2),
                    Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          fontFamily: GoogleFonts.outfit().fontFamily,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.1),
                    Text("E-mail",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontSize: 22,
                        )),
                    SizedBox(height: height * 0.005),
                    TextFormField(
                      controller: EmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter email",
                          hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            color: Color(0xff9796A1),
                            fontWeight: FontWeight.w300,
                            fontFamily: GoogleFonts.outfit().fontFamily,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xffDCDCDC))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xffDCDCDC))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Color(0xffDCDCDC)))),
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'enter the vaild email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text("Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontSize: 22,
                        )),
                    SizedBox(height: height * 0.005),
                    TextFormField(
                      controller: PasswordController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: " Enter Password",
                          hintStyle:
                         TextStyle(
                            fontSize: 14,
                            color: Color(0xff9796A1),
                            fontWeight: FontWeight.w300,
                            fontFamily: GoogleFonts.outfit().fontFamily,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xffD0D2D1),
                            ),
                            onPressed: () {
                              setState(
                                    () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xffDCDCDC))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xffDCDCDC))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Color(0xffDCDCDC)))),
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter the valid password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResetEmail(),
                                ));

                            //Get.to(()=> ResetEmail());

                          },
                          child: Text("Forgot password?",
                              style: TextStyle(
                                  fontSize: 16,fontWeight: FontWeight.w300,
                                  color: Colors.black45,
                                  fontFamily:
                                  GoogleFonts.outfit().fontFamily))),
                    ),
                    SizedBox(height: height * 0.05),

                    Center(
                      child: MyButton(title:"Login",
                        txtStyle: TextStyle(
                          fontSize: 18,color: Colors.white,fontFamily:GoogleFonts.outfit().fontFamily,
                        ),
                        bgColor:Color.fromRGBO(255,255,255,0.21),
                        side: BorderSide(
                            color: Colors.white
                        ),
                        onTap:(){
                      Get.to(()=>ChatPage());
                        },
                        height: height*.06,
                        width: width*0.5),),
                    SizedBox(height: height * 0.01),
                    Row(children: <Widget>[
                      Expanded(
                          child: Divider(indent: 35, color: Color(0xffDCDCDC))),
                      Text("  sign in with  ",
                          style:TextStyle(fontSize: 16,color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontFamily: GoogleFonts.outfit().fontFamily)),
                      Expanded(
                          child: Divider(endIndent: 35, color: Color(0xffDCDCDC))),
                    ]),
                    SizedBox(height:height*0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap:(){
                            facebooklaunch();
                          },
                          child:Image.asset("assets/facebook.png"),),
                        SizedBox(width: width*0.03),
                        GestureDetector(
                          onTap: (){
                            googlelaunch();
                          },
                          child:Image.asset("assets/google.png"),),

                      ],
                    ),
                    // Spacer(),
                    SizedBox(height: height*0.07),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Don't have an account?",
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily:
                                        GoogleFonts.outfit().fontFamily)
                                ),
                                TextSpan(
                                    text: " Sign Up",
                                    style:TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white24,
                                        fontFamily: GoogleFonts.outfit().fontFamily,
                                        decoration: TextDecoration.underline
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(()=> Signup_Page());
                                    }
                                    )
                              ])),
                          SizedBox(height: height * 0.09),
                        ],
                      ),
                    )
                  ],
                ),
                ),
              ),
        ],
      ),
    ),
    );
  }
}
