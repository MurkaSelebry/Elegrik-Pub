import 'package:flutter/material.dart';
import 'package:frontend/user_category/employee/screens/employee_main.dart';
import 'package:frontend/user_category/admin/admin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        '/employee': (context) => EmployeeMainPage(),
        '/admin': (context) => AdminPage(),
      },
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nickFocusNode = FocusNode();

  String _email = '';
  String _password = '';
  String _nick = '';

  String? _emailError;
  String? _passwordError;
  String? _nickError;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nickFocusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  String? _validateNick(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your nick';
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Nick: $_nick');
      print('Email: $_email');
      print('Password: $_password');
      Navigator.pushReplacementNamed(context, '/employee');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFDBC8),
            borderRadius: BorderRadius.circular(16.0),
          ),
          width: screenWidth * 0.5,
          height: screenHeight * 0.5,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nick',
                      errorText: _nickError,
                    ),
                    focusNode: _nickFocusNode,
                    onChanged: (value) {
                      setState(() {
                        _nickError = _validateNick(value);
                      });
                    },
                    validator: _validateNick,
                    onSaved: (value) {
                      _nick = value!;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailError,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    onChanged: (value) {
                      setState(() {
                        _emailError = _validateEmail(value);
                      });
                    },
                    validator: _validateEmail,
                    onSaved: (value) {
                      _email = value!;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError,
                    ),
                    obscureText: true,
                    focusNode: _passwordFocusNode,
                    onChanged: (value) {
                      setState(() {
                        _passwordError = _validatePassword(value);
                      });
                    },
                    validator: _validatePassword,
                    onSaved: (value) {
                      _password = value!;
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _login();
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/admin');
                    },
                    child: Text('Admin'),
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
