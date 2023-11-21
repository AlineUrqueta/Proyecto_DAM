import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_moviles/pages/admin/main_admin.dart';
import '../colores.dart';
import 'package:intl/intl.dart';

import '../widgets/card_evento.dart';
import '../widgets/evento_especifico.dart';
import 'package:proyecto_moviles/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainEventos extends StatefulWidget {
  @override
  State<MainEventos> createState() => _MainEventosState();
}

class _MainEventosState extends State<MainEventos> {
  final formatoFecha = DateFormat('dd-MM-yyyy');

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
              InkWell(
                onTap: (){
                  MaterialPageRoute ruta = MaterialPageRoute(builder: (context) => MainAdmin());
                  Navigator.push(context, ruta);
                },
                child: Icon(MdiIcons.accountCog),
              
              )
              
            ],
          )
        ],),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(children: [
          
          //PROXIMOS EVENTOS
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.amber, 
              borderRadius: BorderRadius.circular(5)),
            child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.calendarClock, color: Colors.white,),
                Text(' Dentro de poco',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
              ],
            ),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
              children: [
                CardEvento(
                  nombre: 'Evento épico',
                  foto: 'blep.png',
                  likes: 789,
                  fecha: '20-11-2023',
                  colorBG: amaNormal,
                  destino: EventoEspecifico(
                    nombre: 'Evento épico',
                    foto: 'blep.png',
                    fecha: '20-11-2023',
                    hora: '20:00',
                    lugar: 'Quinta Vergara, Viña del Mar',
                    tipo: 'Concierto',
                  ),
                ),
                CardEvento(
                  nombre: 'Evento épico',
                  foto: 'blep.png',
                  likes: 789,
                  fecha: '20-11-2023',
                  colorBG: amaNormal,
                ),
              ]
              )
            )
          ],),),

          //BARRA OTROS EVENTOS
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 40,
            decoration: BoxDecoration(color: Color(mBrilloB)),
            child: Row(children: [
              Icon(MdiIcons.calendarSearch,color: Colors.white,),
              Text(' Otros eventos',style: TextStyle(color: Colors.white,fontSize: 15),),
              Spacer(),
              Icon(MdiIcons.filter,color: Colors.white,),
              Text('Filtrar  ',style: TextStyle(color: Colors.white,fontSize: 15))
            ],),
          ),
          
          //OTROS
          Expanded(
            child: StreamBuilder(stream: FirestoreService().eventos(),
                 builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData ||snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.size == 0) {
              return Center(
                child: Text('No hay datos'),
              );
            } else {
              //Llegaron los datos
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var eventos = snapshot.data!.docs[index];
                  //Revisa que el evento ocurra despues de 3 días
                  if((eventos['fechaEvento'] as Timestamp).toDate().isAfter(DateTime.now().add(Duration(days: 3)))){
                    return CardEvento(
                      nombre: eventos['nombre'],
                      foto: 'blep.png',
                      fecha: formatoFecha.format((eventos['fechaEvento'] as Timestamp).toDate()),
                      hora: eventos['horaEvento'],
                      cardID: eventos.id,
                      likes: eventos['likes'],
                      destino: EventoEspecifico(
                        nombre: eventos['nombre'],
                        foto: 'fight.jpg',
                        fecha: formatoFecha.format((eventos['fechaEvento'] as Timestamp).toDate()),
                        hora: eventos['horaEvento'],
                        lugar: eventos['lugar'],
                        tipo: eventos['tipo'],
                        descripcion: eventos['descripcion'],
                      ),
                    );
                  }else{
                    return Center(
                      child: Text('No hay datos'),
                    );
                  }
                }
                  
              );
            }//else llegaron datos
          }))   //StreamBuilder Expanded
        ]),//Column
        ),//Padding
    );//Scaffold
  }
}

