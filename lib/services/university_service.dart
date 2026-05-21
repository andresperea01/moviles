import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/university.dart';

class UniversityService {
  static bool useMock = false;

  static final List<University> _mockUniversities = [
    University(
      id: 'mock-1',
      nit: '890.123.456-7',
      nombre: 'UCEVA',
      direccion: 'Cra 27A #48-144, Tuluá - Valle',
      telefono: '+57 602 2242202',
      paginaWeb: 'https://www.uceva.edu.co',
    ),
    University(
      id: 'mock-2',
      nit: '890.116.032-1',
      nombre: 'Universidad del Valle',
      direccion: 'Calle 13 #100-00, Cali - Valle',
      telefono: '+57 602 3212100',
      paginaWeb: 'https://www.univalle.edu.co',
    ),
    University(
      id: 'mock-3',
      nit: '800.225.119-3',
      nombre: 'Universidad Nacional',
      direccion: 'Carrera 45 # 26-85, Bogotá',
      telefono: '+57 601 3165000',
      paginaWeb: 'https://unal.edu.co',
    ),
  ];

  static final StreamController<List<University>> _mockStreamController = StreamController<List<University>>.broadcast();

  UniversityService() {
    // Inicializar el stream mock
    _mockStreamController.add(_mockUniversities);
  }

  // Stream of universities in real-time
  Stream<List<University>> getUniversities() {
    if (useMock) {
      // Retornar stream mock y agregarle datos al inicio
      _mockStreamController.add(_mockUniversities);
      return _mockStreamController.stream;
    }
    
    try {
      return FirebaseFirestore.instance
          .collection('universidades')
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return University.fromMap(doc.data(), doc.id);
            }).toList();
          });
    } catch (e) {
      if (kDebugMode) {
        print("Error al conectar con Firestore, usando datos simulados: $e");
      }
      useMock = true;
      _mockStreamController.add(_mockUniversities);
      return _mockStreamController.stream;
    }
  }

  // Create a new university
  Future<void> addUniversity(University university) async {
    if (useMock) {
      final newUni = University(
        id: 'mock-${DateTime.now().millisecondsSinceEpoch}',
        nit: university.nit,
        nombre: university.nombre,
        direccion: university.direccion,
        telefono: university.telefono,
        paginaWeb: university.paginaWeb,
      );
      _mockUniversities.add(newUni);
      _mockStreamController.add(List.from(_mockUniversities));
      return;
    }
    
    try {
      await FirebaseFirestore.instance.collection('universidades').add(university.toMap());
    } catch (e) {
      if (kDebugMode) {
        print("Error al agregar a Firestore, agregando localmente: $e");
      }
      // Fallback local
      final newUni = University(
        id: 'mock-${DateTime.now().millisecondsSinceEpoch}',
        nit: university.nit,
        nombre: university.nombre,
        direccion: university.direccion,
        telefono: university.telefono,
        paginaWeb: university.paginaWeb,
      );
      _mockUniversities.add(newUni);
      _mockStreamController.add(List.from(_mockUniversities));
    }
  }

  // Update an existing university
  Future<void> updateUniversity(University university) async {
    if (useMock || university.id.startsWith('mock-')) {
      final index = _mockUniversities.indexWhere((u) => u.id == university.id);
      if (index != -1) {
        _mockUniversities[index] = university;
        _mockStreamController.add(List.from(_mockUniversities));
      }
      return;
    }
    
    try {
      await FirebaseFirestore.instance.collection('universidades').doc(university.id).update(university.toMap());
    } catch (e) {
      if (kDebugMode) {
        print("Error al actualizar en Firestore, actualizando localmente: $e");
      }
      final index = _mockUniversities.indexWhere((u) => u.id == university.id);
      if (index != -1) {
        _mockUniversities[index] = university;
        _mockStreamController.add(List.from(_mockUniversities));
      }
    }
  }

  // Delete a university
  Future<void> deleteUniversity(String id) async {
    if (useMock || id.startsWith('mock-')) {
      _mockUniversities.removeWhere((u) => u.id == id);
      _mockStreamController.add(List.from(_mockUniversities));
      return;
    }
    
    try {
      await FirebaseFirestore.instance.collection('universidades').doc(id).delete();
    } catch (e) {
      if (kDebugMode) {
        print("Error al eliminar en Firestore, eliminando localmente: $e");
      }
      _mockUniversities.removeWhere((u) => u.id == id);
      _mockStreamController.add(List.from(_mockUniversities));
    }
  }
}
