import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_get/app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/loading.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class Student {
  String nim;
  String name;
  String major;

  Student(this.nim, this.name, this.major);
}

class MyApp extends StatelessWidget {
  final CAuth = Get.put(AuthController(), permanent: true);
  final List<Student> students = [];

  final TextEditingController nimController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController majorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Aplikasi Data Mahasiswa'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nimController,
                decoration: InputDecoration(labelText: 'NIM'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: majorController,
                decoration: InputDecoration(labelText: 'Jurusan'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  addStudent();
                },
                child: Text('Input Data Mahasiswa'),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: ListTile(
                        title: Text('NIM: ${students[index].nim}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama: ${students[index].name}'),
                            Text('Jurusan: ${students[index].major}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteStudent(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addStudent() {
    final nim = nimController.text;
    final name = nameController.text;
    final major = majorController.text;

    if (nim.isNotEmpty && name.isNotEmpty && major.isNotEmpty) {
      students.add(Student(nim, name, major));
      nimController.clear();
      nameController.clear();
      majorController.clear();
    }
  }

  void deleteStudent(int index) {
    students.removeAt(index);
  }
}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: CAuth.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            title: "Application",
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? Routes.HOME
                    : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }
        return Loading();
      },
    );
  }
  
  class CAuth {
  static var streamAuthStatus;
  }

