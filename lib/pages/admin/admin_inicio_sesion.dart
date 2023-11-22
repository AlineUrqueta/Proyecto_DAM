import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:proyecto_moviles/colores.dart';
import 'package:proyecto_moviles/pages/admin/administrar_eventos.dart';
import 'package:proyecto_moviles/pages/admin/evento_agregar.dart';
import 'package:proyecto_moviles/pages/admin/main_admin.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AdminInicioSesion extends StatefulWidget {
  const AdminInicioSesion({super.key});

  @override
  State<AdminInicioSesion> createState() => _AdminInicioSesionState();
}

class _AdminInicioSesionState extends State<AdminInicioSesion> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((event) { 
      setState(() {
        _user = event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user != null ? _mainAdmin() :_googleSignInButton(),
    );
  }

  Widget _mainAdmin(){
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
              IconButton(onPressed: ()async{
                _auth.signOut();
              }, icon:  Icon(MdiIcons.logout,color: Colors.white,))
             
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
  
  Widget _googleSignInButton(){
    return Container(
        decoration: BoxDecoration(color: Color(mBrilloB)),
        margin: EdgeInsets.fromLTRB(10, 100, 10, 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(),
                child: Text(
                  'Inicio de Sesion Administrador',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SignInButton(Buttons.google, onPressed: handleGoogleSignIn),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(

                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: const Color.fromARGB(255, 255, 255, 255))))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Volver a Eventos',style: TextStyle(color:Colors.black),))
            ],
          ),
        ),
      );
  }

  void handleGoogleSignIn(){
    try{
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    }catch(error){
      print(error);
    }
  }
}
