import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardEvento extends StatelessWidget {
  final String nombre;
  final String foto;
  final int likes;
  final String fecha;
  final String hora;
  final int colorBG;
  final Widget? destino;

  CardEvento({this.nombre = '',this.foto = '',this.likes = 0,this.fecha = '01-01-2001',this.hora = '',this.colorBG = 0xFF5832A8,this.destino});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(8),
        width: 350,
        decoration: BoxDecoration(color: Color(this.colorBG), borderRadius: BorderRadius.circular(5)),
        child: Column(children: [
          Text(this.fecha + "|" + this.hora, style: TextStyle(color: Colors.white),),
          Image.asset('assets/images/${this.foto}',height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(this.nombre,style: TextStyle(fontSize: 18,color: Colors.white),),
              Column(
                children: [
                  Icon(MdiIcons.heart, color: Colors.white,),
                  Text((this.likes).toString(),style: TextStyle(color: Colors.white,fontSize: 10),)
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