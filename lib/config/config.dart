import 'dart:convert';

import 'package:flutter/services.dart';

class Configuration {
  static Future<Map<String, dynamic>> getConfig() {
    return rootBundle.loadString('assets/config/config.json').then(
          (value) => jsonDecode(value) as Map<String, dynamic>,
        );
  }
}













// import 'dart:convert';

// import 'package:flutter/services.dart';

// class Configuration {
  
//   Future<Map<String, dynamic>> getConfig() {
//     rootBundle.loadString('assets/config/config.json').then((value) {
//       //jsonDecode as 
//       return jsonDecode(value) as Map<String,dynamic>;
//     });
//   }
// }
