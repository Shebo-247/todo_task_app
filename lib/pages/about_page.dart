import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: Column(
        children: <Widget>[
          AboutCard(title: 'Version', data: '1.0'),
          AboutCard(title: 'Developed By', data: 'Niyat'),
          AboutCard(title: 'Contact', data: '+966539090781'),
          SizedBox(height: 35),
          Text(
            'Our Socials',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SocialButton(
                icon: FontAwesomeIcons.facebookSquare,
                color: Colors.blueAccent,
                link: 'https://www.facebook.com/niyatksa/',
              ),
              SocialButton(
                  icon: FontAwesomeIcons.twitterSquare,
                  color: Color(0xFF00ACEE),
                  link: 'https://twitter.com/Niyatksa'),
              SocialButton(
                  icon: FontAwesomeIcons.instagramSquare,
                  color: Color(0xFF3F729B),
                  link: 'https://www.instagram.com/niyatksa/'),
              SocialButton(
                icon: FontAwesomeIcons.linkedin,
                color: Color(0xFF0E76A8),
                link: 'https://www.linkedin.com/in/niyatksa/',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final icon, color, link;
  SocialButton({this.icon, this.color, this.link});

  _launchURL(context) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      Toast.show(
        'Some Error happened !',
        context,
        gravity: Toast.BOTTOM,
        duration: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: () => _launchURL(context),
      child: FaIcon(
        icon,
        size: 50,
        color: color,
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  final String title, data;

  AboutCard({this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                data,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
