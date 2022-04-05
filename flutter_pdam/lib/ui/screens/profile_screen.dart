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
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xffffffff),
                      backgroundImage: NetworkImage(
                          "https://dc722jrlp2zu8.cloudfront.net/media/teachers/miguel-campos-front.webp"),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "200",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "publicacio...",
                              style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.4,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              "1.5M",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Seguidores",
                              style: TextStyle(
                                letterSpacing: 0.4,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              "1",
                              style: TextStyle(
                                letterSpacing: 0.4,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                         
                       
                       
                        Text(
                          "Siguiendo",
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontSize: 15,
                          ),
                        )
                          ]),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "miguel 🤙🤙🤙",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "programer🤙🤙🤙",
                  style: TextStyle(
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                barra1(context),
                SizedBox(height: 10),
                barra2(context),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 20,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 24.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 24.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 24.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                    ],
                  ),
                ),
                 const Divider(
                  height: 20,
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