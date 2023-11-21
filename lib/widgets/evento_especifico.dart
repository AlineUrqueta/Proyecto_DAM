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
  final String descripcion;

  EventoEspecifico({this.nombre = '',this.foto = '',this.fecha = '01-01-2001',this.hora = '00:00',this.lugar = '',this.tipo='',this.descripcion = ''});

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
                        Text(this.descripcion,style: TextStyle(color: Color(mBrilloB),fontSize: 16),),
                      ],
                    )),
                ),
                     
            ],)
        ]),
      ),
    );
  }
}