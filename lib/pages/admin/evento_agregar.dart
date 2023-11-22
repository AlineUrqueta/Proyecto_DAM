import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_moviles/pages/admin/main_admin.dart';
import 'package:proyecto_moviles/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../colores.dart';

class EventoAgregarPage extends StatefulWidget {
  const EventoAgregarPage({super.key});

  @override
  State<EventoAgregarPage> createState() => _EventoAgregarPageState();
}

class _EventoAgregarPageState extends State<EventoAgregarPage> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController fotografiaCtrl = TextEditingController();
  TextEditingController lugarCtrl = TextEditingController();
  DateTime fechaEvento = DateTime.now();
  TimeOfDay horaEvento = TimeOfDay.now();
  String horaEventoString = '00:00';

  String tipo = '';
  String rutaFoto = '';

  final formatoFecha = DateFormat('dd-MM-yyyy');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Evento',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.amber,
        leading: Icon(
          MdiIcons.plusCircle,
          color: Colors.white,
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: TextFormField(
                        controller: nombreCtrl,
                        decoration: InputDecoration(
                            label: Text('Nombre'),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        validator: (nombre) {
                          if (nombre!.isEmpty) {
                            return 'Indique nombre del evento';
                          }
                          if (nombre.length < 3) {
                            return 'El nombre debe tener mínimo 3 letras';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: TextFormField(
                        controller: descripcionCtrl,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        maxLength: 250,
                        decoration: InputDecoration(
                            label: Text('Descripción'),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        validator: (descripcion) {
                          if (descripcion!.isEmpty) {
                            return 'Describa el evento';
                          }
                          if (descripcion.length < 15) {
                            return 'La descripción debe tener minimo 15 letras';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: TextFormField(
                        controller: lugarCtrl,
                        decoration: InputDecoration(
                            label: Text('Lugar'),
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        validator: (lugar) {
                          if (lugar!.isEmpty) {
                            return 'Indique el lugar del evento';
                          }
                          if (lugar.length < 5) {
                            return 'El lugar debe tener minimo 5 letras';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: FutureBuilder(
                          future: FirestoreService().tipos(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              var tipos = snapshot.data!.docs;
                              return DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    labelText: 'Tipo Evento',
                                    border: OutlineInputBorder()),
                                value: tipo == '' ? tipos[0]['nombre'] : tipo,
                                
                                items:
                                    tipos.map<DropdownMenuItem<String>>((tipo) {
                                  return DropdownMenuItem<String>(
                                    child: Text(tipo['nombre']),
                                    value: tipo['nombre'],
                                  );
                                }).toList(),
                                onChanged: (tipoSeleccionado) {
                                  setState(() {
                                    tipo = tipoSeleccionado!;
                                  });
                                },
                              );
                            }
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: [
                            Text('Fecha del Evento  '),
                            Text(formatoFecha.format(fechaEvento)),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2025),
                                          locale: Locale('es', 'ES'))
                                      .then((fecha) {
                                    setState(() {
                                      fechaEvento = fecha ?? fechaEvento;
                                    });
                                  });
                                },
                                icon: Icon(MdiIcons.calendar)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: [
                            Text('Hora del Evento  '),
                            Text(horaEvento.format(context)),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((hora) {
                                    setState(() {
                                      horaEvento = hora ?? horaEvento;
                                      final minutoFormateado =
                                          horaEvento.minute < 10
                                              ? '0' +
                                                  horaEvento.minute.toString()
                                              : horaEvento.minute.toString();
                                      horaEventoString =
                                          horaEvento.hour.toString() +
                                              ":" +
                                              minutoFormateado;
                                    });
                                  });
                                },
                                icon: Icon(MdiIcons.clock)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Agregar Foto'),
                            Icon(MdiIcons.upload)
                          ],
                        ),
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.gallery);

                          if (file == null) return;
                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');

                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);

                          try {
                            await referenceImageToUpload
                                .putFile(File(file.path));

                            rutaFoto =
                                await referenceImageToUpload.getDownloadURL();
                            if (rutaFoto.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Imagen ingresada!')));
                            }
                          } catch (error) {}
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FilledButton.tonal(
                      style: FilledButton.styleFrom(
                          backgroundColor: Color(mBrilloB)),
                      child: Text('Cancelar',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        MaterialPageRoute ruta = MaterialPageRoute(
                            builder: (context) => MainAdmin());
                        Navigator.push(context, ruta);
                      },
                    ),
                    FilledButton.tonal(
                      style:
                          FilledButton.styleFrom(backgroundColor: Colors.amber),
                      child: Text('Agregar',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (rutaFoto.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Ingrese una imagen')));
                        }
                        if (formKey.currentState!.validate() && rutaFoto.isNotEmpty ) {
                          FirestoreService().eventoAgregar(
                              nombreCtrl.text,
                              lugarCtrl.text,
                              descripcionCtrl.text,
                              tipo,
                              fechaEvento,
                              horaEventoString,
                              1,
                              0,
                              rutaFoto);
                          MaterialPageRoute ruta = MaterialPageRoute(builder: (context)=> MainAdmin());
                          Navigator.push(context, ruta);
   
                        }
                        }
                      ,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
