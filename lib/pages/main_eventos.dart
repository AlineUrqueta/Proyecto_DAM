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
        title: Row(
          children: [
            Text('Eventos Team GPB',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      MaterialPageRoute ruta =
                          MaterialPageRoute(builder: (context) => MainAdmin());
                      Navigator.push(context, ruta);
                    },
                    child: Icon(
                      MdiIcons.accountCog,
                      size: 35,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(children: [
          //PROXIMOS EVENTOS
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.calendarClock,
                      color: Colors.white,
                    ),
                    Text(' Dentro de poco',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: FirestoreService().eventos(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
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
                            //Revisa que el evento ocurra antes de 3 días
                            if ((eventos['fechaEvento'] as Timestamp)
                                .toDate()
                                .isBefore(
                                    DateTime.now().add(Duration(days: 3)))) {
                              return CardEvento(
                                nombre: eventos['nombre'],
                                foto: eventos['rutaFoto'],
                                fecha: formatoFecha.format(
                                    (eventos['fechaEvento'] as Timestamp)
                                        .toDate()),
                                hora: eventos['horaEvento'],
                                cardID: eventos.id,
                                likes: eventos['likes'],
                                destino: EventoEspecifico(
                                  nombre: eventos['nombre'],
                                  foto: eventos['rutaFoto'],
                                  fecha: formatoFecha.format(
                                      (eventos['fechaEvento'] as Timestamp)
                                          .toDate()),
                                  hora: eventos['horaEvento'],
                                  lugar: eventos['lugar'],
                                  tipo: eventos['tipo'],
                                  descripcion: eventos['descripcion'],
                                ),
                              );
                            } else {
                              return Container(); //Vacío para que no retorne ningun texto
                            }
                          });
                    } //else llegaron datos
                  })),

          //BARRA OTROS EVENTOS
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 40,
            decoration: BoxDecoration(color: Color(mBrilloB)),
            child: Row(
              children: [
                Icon(
                  MdiIcons.calendarSearch,
                  color: Colors.white,
                ),
                Text(
                  'Todos los eventos',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                // Spacer(),
                // Icon(
                //   MdiIcons.filter,
                //   color: Colors.white,
                // ),
                // Text('Filtrar  ',
                //     style: TextStyle(color: Colors.white, fontSize: 15))
              ],
            ),
          ),

          //OTROS
          Expanded(
              child: StreamBuilder(
                  stream: FirestoreService().eventos(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
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
                            if(eventos['estado']==1){
                              return CardEvento(
                                nombre: eventos['nombre'],
                                foto: eventos['rutaFoto'],
                                fecha: formatoFecha.format(
                                    (eventos['fechaEvento'] as Timestamp)
                                        .toDate()),
                                hora: eventos['horaEvento'],
                                cardID: eventos.id,
                                likes: eventos['likes'],
                                destino: EventoEspecifico(
                                  nombre: eventos['nombre'],
                                  foto: eventos['rutaFoto'],
                                  fecha: formatoFecha.format(
                                      (eventos['fechaEvento'] as Timestamp)
                                          .toDate()),
                                  hora: eventos['horaEvento'],
                                  lugar: eventos['lugar'],
                                  tipo: eventos['tipo'],
                                  descripcion: eventos['descripcion'],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    } //else llegaron datos
                  })),
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 40,
            decoration: BoxDecoration(color: Color(mBrilloB)),
            child: Row(
              children: [
                Icon(
                  MdiIcons.calendarSearch,
                  color: Colors.white,
                ),
                Text(
                  'Eventos finalizados',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                // Spacer(),
                // Icon(
                //   MdiIcons.filter,
                //   color: Colors.white,
                // ),
                // Text('Filtrar  ',
                //     style: TextStyle(color: Colors.white, fontSize: 15))
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: FirestoreService().eventos(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
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
                            if (eventos['estado']==0) {
                              return CardEvento(
                                nombre: eventos['nombre'],
                                foto: eventos['rutaFoto'],
                                fecha: formatoFecha.format(
                                    (eventos['fechaEvento'] as Timestamp)
                                        .toDate()),
                                hora: eventos['horaEvento'],
                                cardID: eventos.id,
                                likes: eventos['likes'],
                                destino: EventoEspecifico(
                                  nombre: eventos['nombre'],
                                  foto: eventos['rutaFoto'],
                                  fecha: formatoFecha.format(
                                      (eventos['fechaEvento'] as Timestamp)
                                          .toDate()),
                                  hora: eventos['horaEvento'],
                                  lugar: eventos['lugar'],
                                  tipo: eventos['tipo'],
                                  descripcion: eventos['descripcion'],
                                ),
                              );
                            } else {
                              return Container(); //Vacío para que no retorne ningun texto
                            }
                          });
                    } //else llegaron datos
                  }))
          //StreamBuilder Expanded
        ]), //Column
      ), //Padding
    ); //Scaffold
  }
}
