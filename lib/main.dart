import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sasai/detailscreen.dart';
import 'package:sasai/model/custom_error.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final packageInfo = await PackageInfo.fromPlatform();
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      debugShowCheckedModeBanner: false,
      home: ErrorLogger(packageInfo.version),
    ),
  );
}

class ErrorLogger extends StatefulWidget {
  final String version;

  const ErrorLogger(this.version, {Key? key}) : super(key: key);

  @override
  State<ErrorLogger> createState() => _ErrorLoggerState();
}

class _ErrorLoggerState extends State<ErrorLogger> {
  @override
  void initState() {
    super.initState();
    _apiFunction1();
    _apiFunction2();
    _apiFunction3();
    logErrorFile("This is an error message.");
  }

  Future<void> _apiFunction1() async {
    const url =
        'https://staging.sasaipaymentgateway.com/staging-bff/v1/auth/token'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('API Function 1 successful: $responseData');
      } else {
        print('API Function 1 failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('API Function 1 failed with error: $e');
    }
  }

  Future<void> _apiFunction2() async {
    const url =
        'https://staging.sasaipaymentgateway.com/staging-bff/v1/master/country'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('API Function 2 successful: $responseData');
      } else {
        print('API Function 2 failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('API Function 2 failed with error: $e');
    }
  }

  Future<void> _apiFunction3() async {
    const url =
        'https://staging.sasaipaymentgateway.com/staging-bff/v1/config/section/data?keys[]=MERCHANT'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('API Function 3 successful: $responseData');
      } else {
        print('API Function 3 failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('API Function 3 failed with error: $e');
    }
  }

// class _ErrorLoggerState extends State<ErrorLogger> {
//   @override
//   void initState() {
//     super.initState();
//     _apiFunction1();
//     _apiFunction2();
//     _apiFunction3();
//     logErrorFile("This is an error message.");
//     hardcode(); // Call the hardcode function
//   }

//   // ... (existing code for _apiFunction1, _apiFunction2, _apiFunction3, and logErrorFile)

//   Future<void> hardcode() async {
//     // Sample data to send in the request
//     Map<String, dynamic> requestData = {
//       'key1': 'value1',
//       'key2': 'value2',
//       // Add other data as needed
//     };

//     try {
//       // Step 1: Make an HTTP request with the first set of data
//       final response1 = await http.post(
//         Uri.parse('https://example.com/endpoint1'),
//         body: requestData,
//       );

//       // Check if the first request was successful
//       if (response1.statusCode == 200) {
//         final responseData1 = json.decode(response1.body);

//         // Process the response if needed

//         // Step 2: Prepare the next set of data based on the response
//         Map<String, dynamic> nextData = {
//           'key3': 'value3',
//           'key4': responseData1['someKey'], // Adjust as per your response structure
//           // Add other data as needed
//         };

//         // Step 3: Make a second HTTP request with the next set of data
//         final response2 = await http.post(
//           Uri.parse('https://example.com/endpoint2'),
//           body: nextData,
//         );

//         // Check if the second request was successful
//         if (response2.statusCode == 200) {
//           final responseData2 = json.decode(response2.body);

//           // Process the response if needed

//           // Continue the pattern for additional steps if necessary
//         } else {
//           print('Second request failed with status code: ${response2.statusCode}');
//           print('Response body: ${response2.body}');
//         }
//       } else {
//         print('First request failed with status code: ${response1.statusCode}');
//         print('Response body: ${response1.body}');
//       }
//     } catch (e) {
//       print('An error occurred during the hardcode process: $e');
//     }
//   }

  //   logErrorFile("This is an error message.");
  // }

  // Method to log errors to a file
  //=> void logErrorFile(String errorMessage) {

  // Implement your logic to log errors to a file here.
  // For this example, we'll just print the error message.

  Future<void> logErrorFile(String errorMessage) async {
    final file = await _localFile; // Get the platform-specific file path
    // Check if the file exists
    final response = http.Response(
        'Sample response', 500); // Replace with your HTTP response

    final newResponseCode = response.statusCode;
    // Check if the file exists
    if (!file.existsSync()) {
      // If the file doesn't exist, create it and write the initial response
      final customError = CustomError(
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        url: 'https://example.com', // Replace with the URL you want to log
        response: 'Sample response $newResponseCode',
      );

      // Encode the custom error to JSON and write it to the file
      final jsonData = customError.toJson();
      try {
        file.writeAsStringSync(json.encode(jsonData));
        print('File created and data written.');
      } catch (e) {
        print('Error creating or writing to the file: $e');
      }
    } else {
      // If the file exists, read its contents and append the new response data
      final existingData = file.readAsStringSync();
      final customError = CustomError.fromJson(json.decode(existingData));
      customError.timeStamp = DateTime.now().millisecondsSinceEpoch;

      final responsePart = customError.response!.split(' ')[2];
      final existingResponseCode = int.parse(responsePart);

      // Check if the response code has changed
      if (existingResponseCode != newResponseCode) {
        customError.timeStamp = DateTime.now().millisecondsSinceEpoch;
        customError.response = 'Sample response $newResponseCode';

        // Encode the updated custom error to JSON and save it back to the file
        final updatedData = customError.toJson();
        try {
          file.writeAsStringSync(json.encode(updatedData));
          print('Data appended to the file.');
        } catch (e) {
          print('Error appending data to the file: $e');
        }
      }
    }
  }

  Future<List<String>> fetchData() async {
    final file = await _localFile;
    if (file.existsSync()) {
      final existingData = file.readAsStringSync();
      final customError = CustomError.fromJson(json.decode(existingData));
      return [
        'Error at ${DateTime.fromMillisecondsSinceEpoch(customError.timeStamp as int)}: ${customError.response}'
      ];
    } else {
      return ['No error data available'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('isDataWritten')),
        body: ListView(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => DetailScreen()));
            //   },
            // ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 237, 237),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              child: Container(
                                height: 45,
                                width: 65,
                                margin:
                                    const EdgeInsets.only(left: 0, right: 85),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  border: Border.all(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(115, 85)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Post',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              child: InkWell(
                                child: Container(
                                  height: 45,
                                  width: 65,
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 0, right: 85),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 141, 211, 75),
                                    border: Border.all(
                                        color: Colors.grey, width: 0.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.elliptical(115, 85)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '200',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'https://staging.sasaipaymentgateway.com/staging-bff/v1/auth/token',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   fetchDateTime()() != null
                            //       ? 'Date and Time: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(fetchDateTime()!)}'
                            //       : 'No error data available',
                            // ),
                            Text(''),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailScreen()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 237, 237),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              child: Container(
                                height: 45,
                                width: 65,
                                margin:
                                    const EdgeInsets.only(left: 0, right: 85),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 56, 145, 34),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(115, 85)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Get',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              child: Container(
                                height: 45,
                                width: 65,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 0, right: 85),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 141, 211, 75),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(115, 85)),
                                ),
                                child: const Center(
                                  child: Text(
                                    '200',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Text(
                              'https://staging.sasaipaymentgateway.com/staging-bff/v1/master/country',
                              // style: Theme.of(context).textTheme.titleSmall,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent),
                              textAlign: TextAlign.center, maxLines: 2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '25/11/2023 ' ' 13:05:08',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailScreen()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 237, 237),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              child: Container(
                                height: 45,
                                width: 65,
                                margin:
                                    const EdgeInsets.only(left: 0, right: 85),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 56, 145, 34),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(115, 85)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Get',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              child: Container(
                                height: 45,
                                width: 65,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 0, right: 85),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 141, 211, 75),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(115, 85)),
                                ),
                                child: const Center(
                                  child: Text(
                                    '200',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'https://staging.sasaipaymentgateway.com/staging-bff/v1/config/section/data?keys[]=MERCHANT',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '27/11/2023 ' ' 17:05:08',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailScreen()));
                },
              ),
            ),
          ],
        ));
  }

  Future<String?> get _localPath async {
    if (Platform.isIOS) {
      var dir = await getApplicationDocumentsDirectory();
      return dir.path;
    } else if (Platform.isAndroid) {
      var dir = await getExternalStorageDirectory();
      return dir?.path;
    }
    return null;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/sasai_log_v${widget.version}.txt');
  }
}
