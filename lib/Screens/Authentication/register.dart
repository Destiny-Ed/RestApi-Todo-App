import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/Provider/AuthProvider/auth_provider.dart';
import 'package:rest_api_app/Screens/Authentication/login.dart';
import 'package:rest_api_app/Utils/routers.dart';
import 'package:rest_api_app/Utils/snack_message.dart';
import 'package:rest_api_app/Widgets/button.dart';
import 'package:rest_api_app/Widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _firstName.clear();
    _lastName.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register ')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    customTextField(
                      title: 'First Name',
                      controller: _firstName,
                      hint: 'Enter your first name',
                    ),
                    customTextField(
                      title: 'Last Name',
                      controller: _lastName,
                      hint: 'Enter your last name',
                    ),

                    customTextField(
                      title: 'Email',
                      controller: _email,
                      hint: 'Enter you valid email address',
                    ),
                    customTextField(
                      title: 'Password',
                      controller: _password,
                      hint: 'Enter your secured password',
                    ),

                    ///Button
                    Consumer<AuthenticationProvider>(
                        builder: (context, auth, child) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        if (auth.resMessage != '') {
                          showMessage(
                              message: auth.resMessage, context: context);

                          ///Clear the response message to avoid duplicate
                          auth.clear();
                        }
                      });
                      return customButton(
                        text: 'Register',
                        tap: () {
                          if (_email.text.isEmpty ||
                              _password.text.isEmpty ||
                              _firstName.text.isEmpty ||
                              _lastName.text.isEmpty) {
                            showMessage(
                                message: "All fields are required",
                                context: context);
                          } else {
                            auth.registerUser(
                                firstName: _firstName.text.trim(),
                                lastName: _lastName.text.trim(),
                                email: _email.text.trim(),
                                password: _password.text.trim(),
                                context: context);
                          }
                        },
                        context: context,
                        status: auth.isLoading,
                      );
                    }),

                    const SizedBox(
                      height: 10,
                    ),

                    GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const LoginPage());
                      },
                      child: const Text('Login Instead'),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
