import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../providers/auth_provider.dart';

class EvidenceScreen extends StatefulWidget {
  const EvidenceScreen({super.key});

  @override
  State<EvidenceScreen> createState() => _EvidenceScreenState();
}

class _EvidenceScreenState extends State<EvidenceScreen> {
  final _secureStorage = const FlutterSecureStorage();
  
  String _userName = '';
  String _userEmail = '';
  String _tokenStatus = 'Cargando...';

  @override
  void initState() {
    super.initState();
    _loadStoredData();
  }

  Future<void> _loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('user_name') ?? 'No encontrado';
    final email = prefs.getString('user_email') ?? 'No encontrado';
    
    final token = await _secureStorage.read(key: 'access_token');

    setState(() {
      _userName = name;
      _userEmail = email;
      _tokenStatus = token != null ? 'Token presente' : 'Sin token';
    });
  }

  void _logout() async {
    await context.read<AuthProvider>().logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidencia Almacenamiento'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.security, size: 64, color: Colors.indigo),
                  const SizedBox(height: 16),
                  const Text(
                    'Datos Almacenados Localmente',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(height: 32),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Nombre (SharedPreferences)'),
                    subtitle: Text(_userName),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email (SharedPreferences)'),
                    subtitle: Text(_userEmail),
                  ),
                  ListTile(
                    leading: const Icon(Icons.vpn_key),
                    title: const Text('Estado (SecureStorage)'),
                    subtitle: Text(
                      _tokenStatus,
                      style: TextStyle(
                        color: _tokenStatus == 'Token presente' 
                            ? Colors.green 
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _logout,
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Cerrar sesión'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
