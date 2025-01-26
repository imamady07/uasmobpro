import 'dart:io'; // Import untuk File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile App',
      initialRoute: '/',
      routes: {
        '/': (context) => ProfilePage(),
        '/edit-profile': (context) => EditProfilePage(),
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Your Profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/one.jpg'),
              ),
              SizedBox(height: 16),
              Text('Name: Fatik', style: TextStyle(fontSize: 18)),
              Text('Email: klompok3.com', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
                child: Text('Edit Profile'),
              ),
              SizedBox(height: 16),
              Text(
                'Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Card(
                child: ListTile(
                  title: Text('Toyota Avanza - 2024'),
                  subtitle: Text('Status: Active'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String name = "Fatik";
  String email = "klompok3.com";
  List<String> vehicles = ["Toyota Avanza - 2024"];
  XFile? _document;
  bool _isActive = true;
  bool _isOjekActive = false;
  bool _isCustomStatusActive = false;
  File? _profileImage;

  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _vehicleYearController = TextEditingController();

  void _addVehicle() {
    if (_vehicleTypeController.text.isNotEmpty && _vehicleYearController.text.isNotEmpty) {
      setState(() {
        vehicles.add('${_vehicleTypeController.text} - ${_vehicleYearController.text}');
      });
      _vehicleTypeController.clear();
      _vehicleYearController.clear();
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile saved succes!')),
      );
      Navigator.pop(context);
    }
  }

  void _pickDocument() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _document = pickedFile;
    });
  }

  void _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);  // Simpan gambar yang dipilih
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              GestureDetector(
                onTap: _pickProfileImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage == null
                      ? AssetImage('assets/images/pem 1.png')  // Gambar default
                      : FileImage(_profileImage!) as ImageProvider,  // Gambar yang dipilih
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Vehicles',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Column(
                children: vehicles.map((vehicle) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(vehicle, style: TextStyle(fontSize: 16)),
                  ),
                )).toList(),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _vehicleTypeController,
                      decoration: InputDecoration(labelText: 'Vehicle Type'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _vehicleYearController,
                      decoration: InputDecoration(labelText: 'Vehicle Year'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addVehicle,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Upload Document (e.g., License)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _document == null
                  ? ElevatedButton(
                onPressed: _pickDocument,
                child: Text('Pick Document'),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Document: ${_document!.name}'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _pickDocument,
                    child: Text('Change Document'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Active Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isActive ? 'Active' : 'Inactive',
                    style: TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isActive = !_isActive;
                      });
                    },
                    child: Text(_isActive ? 'Deactivate' : 'Activate'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Ojek Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isOjekActive ? 'Active' : 'Inactive',
                    style: TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isOjekActive = !_isOjekActive;
                      });
                    },
                    child: Text(_isOjekActive ? 'Deactivate' : 'Activate'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Custom Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isCustomStatusActive ? 'Active' : 'Inactive',
                    style: TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isCustomStatusActive = !_isCustomStatusActive;
                      });
                    },
                    child: Text(_isCustomStatusActive ? 'Deactivate' : 'Activate'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
