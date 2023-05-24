import 'package:flutter/material.dart';

import '../services/api.dart';

class CreateData extends StatefulWidget {
  const CreateData({super.key});

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Nmae here"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "email here"),
            ),
            TextField(
              controller: desController,
              decoration: const InputDecoration(hintText: "Des here"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  var data = {
                    "name": nameController.text,
                    "email": emailController.text,
                    "des": desController.text,
                  };
                  Api.addUser(data);
                },
                child: const Text("create data"))
          ],
        ),
      ),
    );
  }
}
