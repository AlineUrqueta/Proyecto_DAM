import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BotonLike extends StatelessWidget {
  final bool presionado;
  void Function()? onTap;

  BotonLike({this.presionado = false,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(presionado ? MdiIcons.heart : MdiIcons.heartOutline,color: Colors.white,),
    );
  }
}