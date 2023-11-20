import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../colores.dart';

class EventoEspecifico extends StatelessWidget {
  final String nombre;
  final String foto;
  final String fecha;
  final String lugar;
  final String tipo;
  final String hora;

  EventoEspecifico({this.nombre = '',this.foto = '',this.fecha = '01-01-2001',this.hora = '00:00',this.lugar = '',this.tipo=''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mBrilloB),
        foregroundColor: Colors.white,
        title: Row(children: [
          Text('Eventos Team GPB',style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          Column(
            children: [
              Icon(MdiIcons.accountCog),
              Text('Ingreso Admin',style: TextStyle(fontSize: 8,color: Colors.white),)
            ],
          )
        ],),
      ),

      body: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(mBrilloB),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(MdiIcons.calendarSearch,color: Colors.white,),
              Text(this.nombre,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            ],),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Image.asset('assets/images/${this.foto}')),
            Row(
              children: [
                Icon(MdiIcons.arrowDecision,color: Colors.white,),
                Text(' ${this.tipo}',style: TextStyle(color: Colors.white,fontSize: 16),),
              ],
            ),
            Row(
              children: [
                Icon(MdiIcons.mapMarker,color: Colors.white,),
                Text(' ${this.lugar}',style: TextStyle(color: Colors.white,fontSize: 16),),
              ],
            ),
            Row(
              children: [
                Icon(MdiIcons.clock,color: Colors.white,),
                Text(' ${this.fecha}, ${this.hora}hrs',style: TextStyle(color: Colors.white,fontSize: 16),),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Column(children: [
                Row(
                  children: [
                    Icon(MdiIcons.textBoxSearch,color: Colors.white,),
                  ],
                ),
              ],),
              Container(
                  margin: EdgeInsets.only(top: 2),
                  padding: EdgeInsets.all(4),
                  height: 230,
                  width: 330,
                  decoration: BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(child: 
                    Column(
                      children: [
                        Text('Lorem ipsum dolor sit amet consectetur, adipiscing elit ad porta, mi augue dignissim potenti. Molestie ultrices hendrerit lectus a tristique nibh ut sapien, mi duis habitasse luctus enim diam vel magna, tempus dapibus felis ligula est litora consequat. Aliquet euismod bibendum facilisis urna dis tristique quis sed, nascetur etiam ultrices vehicula tempus suscipit est porttitor taciti, pulvinar habitasse fermentum inceptos nisl aliquam sapien. Lacinia sagittis ridiculus quisque porta est neque taciti iaculis, quam eros auctor sodales inceptos turpis eu justo sapien, massa ad non litora venenatis ut nam. Dis orci class feugiat dui eu elementum accumsan euismod a rutrum, inceptos dapibus integer ullamcorper nullam ultricies nulla habitasse. Luctus nam dui commodo ullamcorper dictumst praesent eget, ornare himenaeos cum porttitor convallis risus duis torquent, netus vivamus iaculis tristique sociis morbi.',style: TextStyle(color: Color(mBrilloB),fontSize: 16),),
                      ],
                    )),
                ),
                     
              
              
            ],)
        ]),
      ),
    );
  }
}