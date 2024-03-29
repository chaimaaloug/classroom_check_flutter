import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prj_flutter/models/course.dart';
import 'package:prj_flutter/models/room.dart';
import 'package:prj_flutter/models/students.dart';
import 'package:prj_flutter/models/session.dart';
import 'package:prj_flutter/views/login_screen.dart';
import 'package:prj_flutter/views/students_list_screen.dart';

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
          room = Room.fromJson(response.data['room']);
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
      body: room == null
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                    const SizedBox(height: 25),
                    Text(
                      'Cours : ${course!.name}',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${course!.shortDescription}',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 28,
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
                                point: LatLng(
                                    room!.geo.latitude, room!.geo.longitude),
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
                          PageRouteBuilder(
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                StudentsListScreen(
                                    students: students, session: session),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.easeInOut; // Vitesse

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade400,
                      ),
                      child: const Text(
                        'Liste des Élèves 👩‍🎓',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LoginScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade400,
                      ),
                      child: const Text(
                        'Connexion 👉🏻',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
