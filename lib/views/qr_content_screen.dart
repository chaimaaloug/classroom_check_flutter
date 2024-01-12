import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prj_flutter/models/course.dart';
import 'package:prj_flutter/models/room.dart';
import 'package:prj_flutter/models/students.dart';
import 'package:prj_flutter/models/session.dart';
import 'package:prj_flutter/views/students_screen.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class QRCodeContentScreen extends StatefulWidget {
  final String qrCodeValue;

  const QRCodeContentScreen({Key? key, required this.qrCodeValue})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QRCodeContentScreenState();
  }
}

class QRCodeContentScreenState extends State<QRCodeContentScreen> {
  Room? room;
  Course? course;
  Students? students;
  Session? session;

  @override
  void initState() {
    super.initState();
    getClassroomData();
  }

  void getClassroomData() async {
    final dio = Dio();
    final response = await dio.get(widget.qrCodeValue);

    try {
      if (response.statusCode == 200) {
        setState(() {
          room = Room.fromJson(response.data);
          course = Course.fromJson(response.data['course']);
          students = Students.fromJson(response.data);
          session = Session.fromJson(response.data['session']);
        });
      } else {
        print('response ${response.statusCode} : ${response.data}');
      }
    } catch (error) {
      print('error ${error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(room!.pictureUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 1.0,
            sigmaY: 1.0,
          ),
          child: ListView(
            children: [
              Card(
                margin: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    room!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FlutterMap(
                    mapController: MapController(),
                    options: MapOptions(
                      initialCenter:
                          LatLng(room!.geo.latitude, room!.geo.longitude),
                      initialZoom: 17,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                      ),
                      MarkerLayer(markers: [
                        Marker(
                          width: 48,
                          height: 48,
                          point:
                              LatLng(room!.geo.latitude, room!.geo.longitude),
                          child: const Icon(
                            Icons.location_on,
                            size: 48,
                            color: Colors.red,
                          ),
                        )
                      ])
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentsListScreen(
                          students: students, session: session),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                ),
                child: const Text(
                  'Liste des Élèves',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
