import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for removing debug banner
import 'package:google_sign_in/google_sign_in.dart';
import 'first.dart'; // Import FirstPage

void main() {
  runApp(LoginApp());
  // Hide the debug banner
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false, // Disable debug banner
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(), // Navigate to FirstPage
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),

              // Day Planner icon
              const Icon(
                Icons.calendar_today, // Replace with your desired icon
                size: 100,
              ),

              const SizedBox(height: 50),

              // Welcome text
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // Email and Password Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Forgot Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: Text('Login'),
              ),

              SizedBox(height: 20),

              // Google Sign-In Button
              ElevatedButton.icon(
                onPressed: _handleSignIn,
                icon: Image.asset(
                  'lib/images/google.png', // Make sure this path is correct
                  width: 24,
                  height: 24,
                ),
                label: Text(''),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Background color
                  onPrimary: Colors.black, // Text color
                ),
              ),
            ],
          ), // Column
        ),
      ),
    );
  }
}
