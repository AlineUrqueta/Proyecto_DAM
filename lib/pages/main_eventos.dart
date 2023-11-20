import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_moviles/pages/admin/main_admin.dart';
import '../colores.dart';

import '../widgets/card_evento.dart';
import '../widgets/evento_especifico.dart';

class MainEventos extends StatelessWidget {
  const MainEventos({super.key});

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
              Container(
                margin: EdgeInsets.all(5),
                child: InkWell(
                  onTap: (){
                    MaterialPageRoute ruta = MaterialPageRoute(builder: (context) => MainAdmin());
                    Navigator.push(context, ruta);
                  },
                  child: Icon(MdiIcons.accountCog,size: 35,),
                
                ),
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
                // CardEvento(
                //   nombre: 'Evento épico',
                //   foto: 'blep.png',
                //   likes: 789,
                //   fecha: '20-11-2023',
                //   colorBG: amaNormal,
                //   destino: EventoEspecifico(
                //     nombre: 'Evento épico',
                //     foto: 'blep.png',
                //     fecha: '20-11-2023',
                //     hora: '20:00',
                //     lugar: 'Quinta Vergara, Viña del Mar',
                //     tipo: 'Concierto',
                //   ),
                // ),
                // CardEvento(
                //   nombre: 'Evento épico',
                //   foto: 'blep.png',
                //   likes: 789,
                //   fecha: '20-11-2023',
                //   colorBG: amaNormal,
                // ),
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
            child: SingleChildScrollView(
                child: Column(
                children: [
                  // CardEvento(
                  //   nombre: 'Evento 1',
                  //   foto: 'fight.jpg',
                  //   likes: 345,
                  //   fecha: '20-11-2024',
                  //   destino: EventoEspecifico(
                  //     nombre: 'Evento 1',
                  //     foto: 'fight.jpg',
                  //     fecha: '20-11-2024',
                  //     hora: '20:00',
                  //     lugar: 'Quinta Vergara, Viña del Mar',
                  //     tipo: 'Concierto',
                  //   ),
                  // ),
                  // CardEvento(
                  //   nombre: 'Evento 2',
                  //   foto: 'mask.jpg',
                  //   likes: 234,
                  //   fecha: '20-11-2024',
                  // ),
                ])
              ),
          )            
        ]),
        ),
    );
  }
}

