import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ModeScreen(),
    );
  }
}

class ModeScreen extends StatefulWidget {
  const ModeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ModeScreenState createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final String _phoneNumber =
      "7987660323"; // Replace with the actual phone number

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendToWhatsApp() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String message = _messageController.text;
      String whatsappUrl = "https://wa.me/$_phoneNumber?text="
          "Name: $name\n"
          "Email: $email\n"
          "Message: $message";

      // ignore: deprecated_member_use
      if (await canLaunch(whatsappUrl)) {
        // ignore: deprecated_member_use
        await launch(whatsappUrl);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not open WhatsApp"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Form'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 184, 127, 231),
              Color.fromARGB(255, 106, 242, 210),
              Color.fromARGB(255, 133, 228, 95)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.4)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.4)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 7, 7, 7),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.4)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _sendToWhatsApp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
