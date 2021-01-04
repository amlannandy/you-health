import 'package:flutter/material.dart';

import '../widgets/PrimaryButton.dart';
import '../widgets/CustomTextField.dart';
import '../services/FirebaseAuthenticationService.dart';

enum AuthMode {
  Login,
  Register,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;

  final FirebaseAuthenticationService _auth = FirebaseAuthenticationService();

  void _switchLoading() => setState(() => _isLoading = !_isLoading);

  void _switchAuthMode() {
    setState(() {
      if (_authMode == AuthMode.Login)
        _authMode = AuthMode.Register;
      else
        _authMode = AuthMode.Login;
    });
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            'assets/images/home.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          userInput(context),
        ],
      ),
    );
  }

  Widget userInput(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: _authMode == AuthMode.Login ? 350 : 420,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(25, 30, 25, 25),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _authMode == AuthMode.Login ? 'Login' : 'Register',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        'With your Email',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  controller: _emailController,
                  labelText: 'Enter your email address',
                  icon: Icons.mail,
                ),
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Enter Password',
                  icon: Icons.security,
                  obscureText: true,
                ),
                _authMode == AuthMode.Login
                    ? Container()
                    : CustomTextField(
                        controller: _confirmPasswordController,
                        labelText: 'Confirm Password',
                        icon: Icons.security,
                        obscureText: true,
                      ),
                PrimaryButton(
                    text: _authMode == AuthMode.Login ? 'LOGIN' : 'REGISTER',
                    onPress: () {
                      if (_authMode == AuthMode.Login) {
                        _auth.loginWithEmail(context, _emailController.text,
                            _passwordController.text, _switchLoading);
                      } else {
                        _auth.registerWithEmail(
                            context,
                            _emailController.text,
                            _passwordController.text,
                            _confirmPasswordController.text,
                            _switchLoading);
                      }
                    },
                    color: Theme.of(context).primaryColor),
                PrimaryButton(
                    text: _authMode == AuthMode.Login
                        ? 'REGISTER INSTEAD'
                        : 'LOGIN INSTEAD',
                    onPress: _switchAuthMode,
                    color: Theme.of(context).primaryColor),
              ],
            ),
    );
  }
}
