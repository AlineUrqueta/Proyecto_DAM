import 'package:flutter/material.dart';
import '../../widgets/card_evento_admin.dart';
import '../../widgets/evento_especifico.dart';

class AdministrarEventos extends StatefulWidget {
  const AdministrarEventos({super.key});

  @override
  State<AdministrarEventos> createState() => _AdministrarEventosState();
}

class _AdministrarEventosState extends State<AdministrarEventos> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: SingleChildScrollView(
                child: Column(
                children: [
                  CardEventoAdmin(
                    nombre: 'Evento 1',
                    foto: 'fight.jpg',
                    fecha: '20-11-2024',
                    destino: EventoEspecifico(
                      nombre: 'Evento 1',
                      foto: 'fight.jpg',
                      fecha: '20-11-2024',
                      hora: '20:00',
                      lugar: 'Quinta Vergara, Viña del Mar',
                      tipo: 'Concierto',
                    ),
                  ),
                  CardEventoAdmin(
                    nombre: 'Evento 2',
                    foto: 'mask.jpg',
                    fecha: '20-11-2024',
                  ),
                  CardEventoAdmin(
                    nombre: 'Evento 3',
                    foto: 'blep.png',
                    fecha: '20-10-2024',
                  ),
                ])
              ),
          );
  }
}