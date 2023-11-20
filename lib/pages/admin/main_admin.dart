import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_moviles/pages/admin/administrar_eventos.dart';
import 'package:proyecto_moviles/pages/admin/evento_agregar.dart';

import '../../colores.dart';

class MainAdmin extends StatelessWidget {
  const MainAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Color(mBrilloB),
        foregroundColor: Colors.white,
        title: Row(children: [
          Icon(MdiIcons.accountCog,color: Colors.white,),
          Text(' Bienvenido Admin',style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          Column(
            children: [
              Icon(MdiIcons.logout,color: Colors.white,)
            ],
          )
        ],),
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Color(mObsB),
          tabs: [
            Tab(icon: Icon(MdiIcons.tools,),),
            Tab(icon: Icon(MdiIcons.plus,),)
          ]
          ),
      ),
      body: TabBarView(children: [
        AdministrarEventos(),
        EventoAgregarPage()
      ],)
      ),
    );
  }
}