import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/config.dart';
import 'package:flutter_application_2/config/internal_config.dart';
import 'package:flutter_application_2/models/request/customer_login_post_req.dart';
import 'package:flutter_application_2/models/request/customer_post_req.dart';
import 'package:flutter_application_2/models/response/customersLoginRes.dart';
import 'package:flutter_application_2/pages/showtrip.dart';

import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String url = '';
  TextEditingController phoneNoCtl = TextEditingController();
  TextEditingController nameNoCtl = TextEditingController();
  TextEditingController emailNoCtl = TextEditingController();
  TextEditingController passNoCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ลงทะเบียนสมาชิกใหม่'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  //ชื่อ-นามสกุล
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 280, 0),
                    child: Text(
                      'ชื่อ-นามสกุล',
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          controller: nameNoCtl,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))))),

                  // หมายเลขโทรศัพท์
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 220, 0),
                    child: Text(
                      'หมายเลขโทรศัพท์',
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          controller: phoneNoCtl,
                          // onChanged: (value) {
                          //  phoneNo = value;
                          // },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))))),

                  // อีเมล์
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 310, 0),
                    child: Text(
                      'อีเมล์',
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          controller: emailNoCtl,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))))),

                  // รหัสผ่าน
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 290, 0),
                    child: Text(
                      'รหัสผ่าน',
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          controller: passNoCtl,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))))),

                  // ยืนยันรหัสผ่าน
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 240, 0),
                    child: Text(
                      'ยืนยันรหัสผ่าน',
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))))),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0), // Adjust the value to move the button down
                  child: FilledButton(
                    onPressed: login,
                    child: const Text('สมัครสมาชิก'),
                  ),
                ),
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        register();
                      },
                      child: const Text(
                        'หากมีบัญชีอยู่แล้ว?',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {
                        register();
                      },
                      child: const Text('ลงทะเบียนใหม่')),
                  // FilledButton(
                  //     onPressed: login, child: const Text('เข้าสู่ระบบ')),
                ],
              ),
              // Text(text),
              // Text(text1)
            ],
          ),
        ));
  }

  void register() {
    // log("This is Register button");
    // setState(() {
    //   text1 = 'Hello World!!!';
    // });
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ));
  }

  void login() {
    // Call login api
    CustomerPostReq req = CustomerPostReq(
        fullname: nameNoCtl.text,
        phone: phoneNoCtl.text,
        email: emailNoCtl.text,
        image: '',
        password: passNoCtl.text);

    http
        .post(Uri.parse("$url/customers"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            // Send json string of object model
            body: customerPostReqToJson(req))
        .then(
      (value) {
        // Convert Json String to Object (Model)
        CustomersLoginPostResponse customer =
            customersLoginPostResponseFromJson(value.body);

        log(customer.customer.email);

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>ShowtripPage(),
        //     ));

        // Convert Json String to Map<String, String
        // var jsonRes = jsonDecode(value.body);
        // log(jsonRes['customer']['email']);
      },
    ).catchError((eee) {
      log(eee.toString());
    });
    // setState(() {
    //   num++;
    //   text = 'Login time: $num';
    // });
    //   log(phoneNoCtl.text);
    //   // log(phoneNo);
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const ShowtripPage(),
    //       ));
  }
}
