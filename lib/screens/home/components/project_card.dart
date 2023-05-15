import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile/models/Project.dart';
import 'package:flutter_profile/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.title,
    required this.description,
    required this.language,
    required this.copyrepos,
    this.languageColor = primaryColor,
    required this.onpree,
  }) : super(key: key);

  final String title, description, language;
  final Color languageColor;
  final VoidCallback onpree;
  final VoidCallback copyrepos;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/icon.png',
                color: Colors.white,
                height: 25,
                width: 25,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              IconButton(
                onPressed: copyrepos,
                icon: Icon(
                  Icons.copy,
                ),
                color: Colors.white54,
              )
            ],
          ),
          Expanded(
            child: Text(
              description,
              maxLines: Responsive.isMobileLarge(context) ? 2 : 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(height: 1.5),
            ),
          ),
          Spacer(),
          Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: languageColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  language,
                  maxLines: Responsive.isMobileLarge(context) ? 3 : 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.5),
                ),
              ),
            ],
          ),
          Spacer(),
          TextButton(
            onPressed: onpree,
            child: Text(
              "Read More >>",
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
