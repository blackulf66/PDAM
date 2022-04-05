 import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../../constants.dart';
class detailsPage extends StatefulWidget {
    
    detailsPage({ Key? key }) : super(key: key);

    @override
    _detailsPageState createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {
    

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Detalle de noticia"),
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent
            ),            
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child:Image(
                            image: NetworkImage('https://estaticos-cdn.prensaiberica.es/clip/7583e1dd-e048-4687-84cd-383a484e6b27_16-9-discover-aspect-ratio_default_0.jpg'),
                                
                          ),
                     
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Titulo' , style: TextStyle(color:Colors.white, fontSize: 30),textAlign:TextAlign.left,),
                    ),
            
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('SubTitulo' , style: TextStyle(color:Colors.white, fontSize: 15),),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left:70, right: 70,),
                      child: Divider(color: Style.VKNGGron,),
                    ),
            
            
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Text('Spider-Man, traducido en ocasiones como Hombre Araña,11​12​ es un personaje creado por los estadounidenses Stan Lee y Steve Ditko,13​14​ e introducido en el cómic Amazing Fantasy n.° 15, publicado por Marvel Comics en agosto de 1962.15​ Se trata de un superhéroe que emplea sus habilidades sobrehumanas, reminiscentes de una araña, para combatir a otros supervillanos que persiguen fines siniestros Su creación se remonta a principios de la década de 1960 como respuesta al creciente interés del público adolescente en los cómics y el éxito de Los 4 Fantásticos.16​ Tras su primera aparición en Amazing Fantasy,17​ Marvel decidió producir una serie individual titulada The Amazing Spider-Man, cuyo ejemplar inicial salió a la venta en marzo de 1963.18​ Desde entonces se han distribuido otros varios cómics relacionados con el personaje, así como otros productos que han derivado en el establecimiento de una franquicia de medios.'
            
                      , style: TextStyle(color:Colors.white, fontSize: 15),),
                    ),
            
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Comentarios' , style: TextStyle(color:Colors.white, fontSize: 15),),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(left:70, right: 70,),
                      child: Divider(color: Style.VKNGGron,),
                    ),
                    //Listview
            
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                           Padding(
                             padding: const EdgeInsets.all(4.0),
                             child: Row(
                               children: [
                                 ClipRRect(
                                  borderRadius:BorderRadius.circular(50.0),
                                  child: Image(
                                    image: NetworkImage('https://estaticos-cdn.prensaiberica.es/clip/7583e1dd-e048-4687-84cd-383a484e6b27_16-9-discover-aspect-ratio_default_0.jpg'),
                                    height: 45.0,
                                    width: 45.0,
                                  ),
                          ),
                          Text('Spider-Man' , style: TextStyle(color:Colors.white, fontSize: 15),)
                               ],
                             ),
                           ),
                          Padding(
                            padding: const EdgeInsets.only(left:30),
                            child: Row(
                              children: [
                                Text('-  ' , style: TextStyle(color:Colors.white, fontSize: 15),textAlign: TextAlign.left,),
                                Text('muy bueno si si si' , style: TextStyle(color:Colors.white, fontSize: 15),textAlign: TextAlign.left,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            
            
            
                ],
              ),
            ),
            
        );
    }
}