import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "miguel 🤙🤙🤙",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      backgroundImage: AssetImage(
                          "assets/images/daily.png"),
                    ),
                   
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget barra1(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        width: MediaQuery.of(context).size.width - 39,
        child: OutlinedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text("editar perfil", style: TextStyle(color: Colors.black)),
          ),
          style: OutlinedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size(0, 30),
              side: BorderSide()),
          onPressed: () {},
        ),
      )
    ]);
  }

  Widget barra2(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        width: MediaQuery.of(context).size.width - 39,
        child: OutlinedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text("herramientas", style: TextStyle(color: Colors.black)),
          ),
          style: OutlinedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size(0, 30),
              side: BorderSide()),
          onPressed: () {},
        ),
      ),
    ]);
  }
}