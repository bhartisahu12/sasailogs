import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 237, 237),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0.50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Method - '),
                  Text(
                    'Post ',
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Status - '),
                  Text(
                    '200',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Date -'),
                  Text(' '),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Text('Url - ', textAlign: TextAlign.center)),
                  Expanded(
                    child: Align(
                      child: Text(
                        'https://staging.sasaipaymentgateway.com/staging-bff/v1/auth/token',
                        style:
                            TextStyle(fontSize: 14, color: Colors.blueAccent),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: Text(
                    'Request - ',
                    textAlign: TextAlign.center,
                  )),
                  Flexible(
                    child: Text(
                        '{"username":"7c6244f0-2d81-4373-86ab-24273cfef4a0","password":"Bx!X73)n","tenantId":"sasai","clientId":"sasai-pay-client"}'),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Text('Response - ')),
                  Expanded(
                    child: Text(''),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
