import 'package:chatapp/ViewScreen/Login/login.dart';
import 'package:chatapp/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetEmail extends StatefulWidget {
  const ResetEmail({super.key});

  @override
  State<ResetEmail> createState() => _ResetEmailState();
}

class _ResetEmailState extends State<ResetEmail> {
  TextEditingController EmailController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        // appBar: AppBar(
        //     elevation: 0,
        //     backgroundColor: Colors.transparent,
        //     leading: GestureDetector(
        //       onTap: () {
        //         Navigator.of(context)
        //             .push(MaterialPageRoute(builder: (context) => LoginPage()));
        //       },
        //       child: Icon(Icons.arrow_back_outlined, color: Colors.black),
        //     )),
        body: Form(
          key: _formKey,
          child: Stack(children: [
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
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.1),


                    Center(
                        child: Text("Reset Password",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.outfit().fontFamily))),
                    SizedBox(height: height * 0.001),
                    Center(
                      child: Text(
                          "Please enter your email address to request a\npassword reset",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: GoogleFonts.outfit().fontFamily)),
                    ),
                    SizedBox(height: height * 0.05),
                    Text("E-mail",
                        style:
                        TextStyle(
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
                    SizedBox(height: height * 0.05),
                    Center(
                      child: MyButton(title:"Send",
                          txtStyle: TextStyle(
                            fontSize: 18,color: Colors.white,fontFamily:GoogleFonts.outfit().fontFamily,
                          ),
                          bgColor:Color.fromRGBO(255,255,255,0.21),
                          side: BorderSide(
                              color: Colors.white
                          ),
                          onTap:(){
                          // Get.to(()=>ChatPage());
                          },
                          height: height*.06,
                          width: width*0.5),),

                  ],
                ),
              )),
            )
          ]),
        ));
  }
}
