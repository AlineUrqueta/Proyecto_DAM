import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_moviles/widgets/boton_like.dart';

class CardEvento extends StatefulWidget {
  final String nombre;
  final String foto;
  final int likes;
  final String fecha;
  final String hora;
  final int colorBG;
  final Widget? destino;
  final String cardID;

  CardEvento({this.nombre = '',this.foto = '',this.likes = 0,this.fecha = '01-01-2001',this.hora = '',this.colorBG = 0xFF5832A8,this.destino,this.cardID=''});

  @override
  State<CardEvento> createState() => _CardEventoState();
}

class _CardEventoState extends State<CardEvento> {
  bool presionado = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        width: 350,
        decoration: BoxDecoration(color: Color(this.widget.colorBG), borderRadius: BorderRadius.circular(5)),
        child: Column(children: [
          Text(this.widget.fecha+ "|" + this.widget.hora, style: TextStyle(color: Colors.white),),
          InkWell(
            child: Image.network(this.widget.foto,height: 200),
            onTap: () {
              if(this.widget.destino!=null){
                MaterialPageRoute ruta = MaterialPageRoute(
                  builder: (context){
                    return this.widget.destino!;
                  }
                  );
                  Navigator.push(context, ruta);
              }
            },
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(this.widget.nombre,style: TextStyle(fontSize: 18,color: Colors.white),),
              Column(
                children: [
                  BotonLike(
                    presionado: presionado,
                    onTap: (){
                      //Cambiar estado
                      setState(() {
                        presionado = !presionado;
                      });
                      //BD
                      DocumentReference eventoRef = FirebaseFirestore.instance.collection('eventos').doc(widget.cardID);
                      if(presionado){
                        eventoRef.update({
                          'likes' : this.widget.likes + 1
                        });
                      }else{
                        eventoRef.update({
                          'likes' : this.widget.likes - 1
                        });
                      }
                    },
                  ),
                  Text(this.widget.likes.toString(),style: TextStyle(color: Colors.white,fontSize: 10),)
                ],
              ),
            ],
          )
        ],),
      );
  }
}