import 'package:flutter/material.dart';

class TestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        testCard(
          context: context,
          title: 'Heart Rate Monitoring',
          subtitle: 'Measure your heart rate with your phone',
          image: 'assets/images/heartrate.jpg',
          onPress: () => Navigator.of(context).pushNamed('/hrm'),
        ),
        testCard(
          context: context,
          title: 'Pneumonia Detection',
          subtitle: 'Check whether your pneumonia is viral or bacterial',
          image: 'assets/images/pneumonia.jpeg',
          onPress: () {},
        ),
        testCard(
          context: context,
          title: 'Skin Disease Detection',
          subtitle: 'Get the rash on your skin checked',
          image: 'assets/images/skin_diseases.jpg',
          onPress: () {},
        ),
      ],
    );
  }

  Widget testCard({
    BuildContext context,
    String title,
    String subtitle,
    String image,
    Function onPress,
  }) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 10,
          right: 10,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Image.asset(
              image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Colors.black45,
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    bottom: 2.5,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 26,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black45,
                  padding: const EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: "Varela",
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
