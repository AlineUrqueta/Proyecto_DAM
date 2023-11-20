import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../colores.dart';

class CardEventoAdmin extends StatelessWidget {
  final String nombre;
  final String foto;
  final String fecha;
  final int colorBG;
  final Widget? destino;

  CardEventoAdmin({this.nombre = '',this.foto = '',this.fecha = '01-01-2001',this.colorBG = 0xFF5832A8,this.destino});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(8),
        width: 350,
        decoration: BoxDecoration(color: Color(this.colorBG), borderRadius: BorderRadius.circular(5)),
        child: Column(children: [
          Text(this.fecha, style: TextStyle(color: Colors.white),),
          Image.asset('assets/images/${this.foto}',height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(this.nombre,style: TextStyle(fontSize: 18,color: Colors.white),),
              Column(
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Color(amaNormal)),
                    child: Icon(MdiIcons.tools),
                    onPressed: (){}),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Color(amaNormal)),
                    child: Icon(MdiIcons.trashCan),
                    onPressed: (){})
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