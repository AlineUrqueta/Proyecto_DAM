import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_moviles/services/firebase_service.dart';
import '../../widgets/card_evento_admin.dart';
import '../../widgets/evento_especifico.dart';

class AdministrarEventos extends StatefulWidget {
  const AdministrarEventos({super.key});

  @override
  State<AdministrarEventos> createState() => _AdministrarEventosState();
}

class _AdministrarEventosState extends State<AdministrarEventos> {
  final formatoFecha = DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(10),
                child: StreamBuilder(stream: FirestoreService().eventos(),
                 builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {

              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.size == 0) {
              return Center(
                child: Text('No hay datos'),
              );
            } else {
              //Llegaron los datos
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(thickness: 0,color: Colors.white,),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var eventos = snapshot.data!.docs[index];
              
                  return CardEventoAdmin(
                    nombre: eventos['nombre'],
                    foto: eventos['rutaFoto'],
                    fecha: formatoFecha.format((eventos['fechaEvento'] as Timestamp).toDate()),
                    hora: eventos['horaEvento'],
                    id: eventos.id,
                    destino: EventoEspecifico(
                      nombre: eventos['nombre'],
                      descripcion :eventos['descripcion'],
                      foto: 'fight.jpg',
                      fecha: formatoFecha.format((eventos['fechaEvento'] as Timestamp).toDate()),
                      hora: eventos['horaEvento'],
                      lugar: eventos['lugar'],
                      tipo: eventos['tipo'],
                    ),
                  );
                },
              );
            }
                 }));
  }
}