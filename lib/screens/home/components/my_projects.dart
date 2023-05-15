import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_profile/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import 'project_card.dart';

List data = [];
dynamic colordata;
bool isloading = true;

languageColor(language) {
  var color = colordata[language]['color'];
  var colors = color.replaceAll('#', '0xff');
  return colors;
}



class MyProjects extends StatefulWidget {
  const MyProjects({
    Key? key,
  }) : super(key: key);

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  @override
  void initState() {
    super.initState();
    getProject();
    getcolors();
  }

  getProject() async {
    setState(() {
      isloading = true;
    });
    var request = http.Request(
        'GET', Uri.parse('https://api.github.com/users/Kinjal-Gajjar/repos'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var d = await response.stream.bytesToString();
      data = (jsonDecode(d) as List<dynamic>);
      setState(() {
        isloading = false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  getcolors() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://raw.githubusercontent.com/ozh/github-colors/master/colors.json'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var d = await response.stream.bytesToString();

      setState(() {
        colordata = jsonDecode(d);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Projects",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: defaultPadding),
          Responsive(
            mobile: ProjectsGridView(
              crossAxisCount: 1,
              childAspectRatio: 1.7,
            ),
            mobileLarge: ProjectsGridView(crossAxisCount: 2),
            tablet: ProjectsGridView(childAspectRatio: 1.1),
            desktop: ProjectsGridView(
              crossAxisCount: 3,
              childAspectRatio: 2,
            ),
          )
        ],
      ),
    );
  }
}

class ProjectsGridView extends StatefulWidget {
  const ProjectsGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<ProjectsGridView> createState() => _ProjectsGridViewState();
}

class _ProjectsGridViewState extends State<ProjectsGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      reverse: true,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: widget.childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) => isloading
          ? Center(
              child: CircularProgressIndicator(
              color: primaryColor,
            ))
          : ProjectCard(
              title: data[index]['name'].toString(),
              description: data[index]['description'].toString(),
              language: data[index]['language'].toString(),
              languageColor:
                  Color(int.parse(languageColor(data[index]['language']))),
              onpree: () {
                print('uelhjghh');
                urllauncher(data[index]['html_url'].toString());
              },
              copyrepos: () {
                Clipboard.setData(ClipboardData(
                        text: data[index]['clone_url'].toString()))
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "${data[index]['name'].toString()} clone url copied to clipboard")));
                });
              },
            ),
    );
  }
}
