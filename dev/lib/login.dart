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

  Widget buildTextField(String labelText, bool obscureText) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F6FB), // Background color
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
              Icon(
                Icons.calendar_today, // Replace with your desired icon
                size: 100,
                color: Color(0xFF007BFF), // Icon color
              ),

              const SizedBox(height: 50),

              // Welcome text
              Text(
                'Welcome back, you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // Email and Password Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: buildTextField('Email', false),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: buildTextField('Password', true),
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
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Color(0xFF2E78C7), Color(0xFF00BFFF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Button color
                    elevation: 0, // Remove button shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Google Sign-In Button
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton.icon(
                  onPressed: _handleSignIn,
                  icon: Image.asset(
                    'lib/images/google.png', // Make sure this path is correct
                    width: 24,
                    height: 24,
                  ),
                  label: Text(
                    'Sign In with Google',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Button color
                    elevation: 0, // Remove button shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ), // Column
        ),
      ),
    );
  }
}
