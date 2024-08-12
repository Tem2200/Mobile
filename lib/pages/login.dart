// import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/config/config.dart';
import 'package:flutter_application_2/models/request/customer_login_post_req.dart';
import 'package:flutter_application_2/models/response/customersLoginRes.dart';

import 'package:flutter_application_2/pages/register.dart';
import 'package:flutter_application_2/pages/showtrip.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = '';
  TextEditingController phoneNoCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  String url = '';
// InitState คือ funtion ที่ทำงานเมื่อเปิดหน้านี้
// 1.จะทำงานแค่ครั้งเดียวเมื่อเปิดหน้านี้
// 2.มันจะไม่ทำงานเมื่อเราเรียก setState
// 3.มันไม่สามมารถทำงานเป็น async funtionได้
  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then(
      (config) {
        url = config['apiEndpoint'];
      },
    ).catchError((err) {
      log(err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    log('Image double tapped');
                  },
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 210, 0),
                  child: Text('หมายเลขโทรศัพท์'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: phoneNoCtl,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 275, 0),
                  child: Text('รหัสผ่าน'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: passwordCtl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    register();
                  },
                  child: const Text('ลงทะเบียนใหม่'),
                ),
                FilledButton(
                  onPressed: login,
                  child: const Text('เข้าสู่ระบบ'),
                  //hello
                ),
              ],
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  void login() {
    // Call login api
    CustomerLoginPostRequest req = CustomerLoginPostRequest(
        phone: phoneNoCtl.text, password: passwordCtl.text);

    http
        .post(Uri.parse('$url/customers/login'),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            // Send json string of object model
            body: customerLoginPostRequestToJson(req))
        .then(
      (value) {
        // Convert Json String to Object (Model)
        CustomersLoginPostResponse customersLoginPostResponse =
            customersLoginPostResponseFromJson(value.body);

        log(customersLoginPostResponse.customer.email);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShowtripPage(cid: customersLoginPostResponse.customer.idx),
            ));
        // Convert Json String to Map<String, String
        // var jsonRes = jsonDecode(value.body);
        // log(jsonRes['customer']['email']);
      },
    ).catchError((eee) {
      log(eee.toString());
    });

    // String phoneNo = phoneCtl.text;
    // String password = passwordCtl.text;

    //  if (phoneNo == '0812345678' && password == '1234') {
    //   setState(() {
    //     text = ''; // Clear any previous error messages
    //   });
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const ShowtripPage(),
    //     ),
    //   );
    // } else {
    //   setState(() {
    //     text = 'หมายเลขโทรศัพท์หรือรหัสผ่านไม่ถูกต้อง';
    //   });
    // }
  }
}




















































// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/pages/register.dart';
// // import 'package:flutter_application_2/pages/showtrip.dart';
// import 'package:http/http.dart' as http;

// class LoginPage extends StatefulWidget {
//   LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final String predefinedPhoneNo = '0812345678';
//   final String predefinedPassword = '1234';

//   String phoneNo = '';
//   String password = '';
//   String errorMessage = '';

//   TextEditingController phoneNoCtl = TextEditingController();
//   TextEditingController passwordCtl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Login Page'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               GestureDetector(
//                 onDoubleTap: () {
//                   log('Image double tapped on page');
//                 },
//                 child: Image.asset('assets/images/logo.png'),
//               ),
//               const Padding(
//                 padding: EdgeInsets.fromLTRB(0, 0, 210, 0),
//                 child: Text('หมายเลขโทรศัพท์'),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: TextField(
//                   controller: phoneNoCtl,
//                   keyboardType: TextInputType.phone,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.fromLTRB(0, 0, 275, 0),
//                 child: Text('รหัสผ่าน'),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: TextField(
//                   controller: passwordCtl,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   TextButton(
//                     onPressed: register,
//                     child: const Text('ลงทะเบียนใหม่'),
//                   ),
//                   FilledButton(
//                     onPressed: login,
//                     child: const Text('เข้าสู่ระบบ'),
//                   ),
//                 ],
//               ),
//               if (errorMessage.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     errorMessage,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ),
//             ],
//           ),
//         ));
//   }

//   void register() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const RegisterPage(),
//       ),
//     );
//   }

//   void login() {
//     http.get(Uri.parse("http://192.168.70.194:3000/customers")).then(
//       (value) {
//         log(value.body);
//       },
//     ).catchError((error) {
//       log('Error $error');
//     });

//     // setState(() {
//     //   phoneNo = phoneNoCtl.text;
//     //   password = passwordCtl.text;

//     //   if (phoneNo == predefinedPhoneNo && password == predefinedPassword) {
//     //     errorMessage = '';
//     //     Navigator.push(
//     //       context,
//     //       MaterialPageRoute(
//     //         builder: (context) => const ShowtripPage(),
//     //       ),
//     //     );
//     //   } else {
//     //     errorMessage = 'หมายเลขโทรศัพท์หรือรหัสผ่านไม่ถูกต้อง';
//     //   }
//     // });
//   }
// }
