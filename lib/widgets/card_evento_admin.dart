import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_moviles/services/firebase_service.dart';
import '../colores.dart';

class CardEventoAdmin extends StatelessWidget {
  final String nombre;
  final String foto;
  final String fecha;
  final String hora;
  final String id;
  final int colorBG;
  final Widget? destino;
  final int estado;


  CardEventoAdmin({this.nombre = '',this.foto = '',this.fecha = '', this.hora = '',this.colorBG = 0xFF5832A8,this.destino,this.id = '',this.estado=1});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(8),
        width: 350,
        decoration: BoxDecoration(color: Color(this.colorBG), borderRadius: BorderRadius.circular(5)),
        child: Column(children: [
          Text(this.fecha + " | " + this.hora, style: TextStyle(color: Colors.white,fontSize: 18),),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Color(amaNormal),width: 5)),
            padding: EdgeInsets.all(5),
            child: 
            Image.network(foto,height: 200)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 230,
                  height: 80,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(color: Color(amaNormal),borderRadius: BorderRadius.all(Radius.circular(10)),border: Border.all(width: 0)),
                  child: Text(this.nombre,style: TextStyle(fontSize: 18,color: Colors.white),),),
             
              Column(
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Color(amaNormal)),
                    child: Icon(estado==1 ? MdiIcons.calendarCheck : MdiIcons.calendarRemove),
                    onPressed: (){
                      DocumentReference eventoRef = FirebaseFirestore.instance.collection('eventos').doc(id);
                      if(estado==1){
                        eventoRef.update({
                          'estado' : 0
                        });
                      }else{
                        eventoRef.update({
                          'estado' : 1
                        });
                      }
                    }),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Color(amaNormal)),
                    child: Icon(MdiIcons.trashCan),
                    onPressed: (){
                      String nomEvento = this.nombre;
                       FirestoreService().eventoBorrar(this.id);
                       
                        ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Evento ${nomEvento} eliminado')));
                      
                    })
                ],
              ),
            ],
          )
        ],),
      ),
      onTap: () {
        if(this.destino!=null){
          MaterialPageRoute ruta = MaterialPageRoute(
            builder: (context){
              return this.destino!;
            }
            );
            Navigator.push(context, ruta);
        }
      },
    );
  }
}