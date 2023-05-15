import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_profile/components/animated_counter.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import 'heigh_light.dart';

class HighLightsInfo extends StatefulWidget {
  const HighLightsInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<HighLightsInfo> createState() => _HighLightsInfoState();
}

class _HighLightsInfoState extends State<HighLightsInfo> {
  dynamic data;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var request = http.Request(
        'GET', Uri.parse('https://api.github.com/users/Kinjal-Gajjar'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var d = await response.stream.bytesToString();

      setState(() {
        data = jsonDecode(d);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          HeighLight(
            counter: AnimatedCounter(
              value: data != null ? data['public_repos'] : 0,
              text: '+',
            ),
            label: "Github Project",
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
