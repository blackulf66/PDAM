// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/ui/screens/menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/loginbloc/bloc/login_bloc.dart';
import '../../models/auth/login_dto.dart';
import '../../models/auth/login_response.dart';
import '../../repository/authrepository/auth_repository.dart';
import '../../repository/authrepository/auth_repository_impl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<SharedPreferences> _prefs;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _prefs = SharedPreferences.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        child: _createBody(context));
        
  }

  _createBody(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,

      body: Center(
        child: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20,0,20,20),
            child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (context, state) {
              return state is LoginSuccessState || state is LoginErrorState;
            }, listener: (context, state) async {
              if (state is LoginSuccessState) {
                _loginSuccess(context, state.loginResponse);
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is LoginInitialState || state is LoginLoadingState;
            }, builder: (ctx, state) {
              if (state is LoginInitialState) {
                return _login(ctx);
              } else if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _login(ctx);
              }
            })),
            
      ),
      
    );
    
  }

  Future<void> _loginSuccess(BuildContext context, LoginResponse late) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString('token', late.token);
      prefs.setString('avatar', late.avatar);
      prefs.setString('nick', late.nick);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MenuScreen()),
      );
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _login(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0,0, 24.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Center(
                child: SizedBox(
                  width: 100.0,
                  height: 120.0,
                  child: DecoratedBox(
                    decoration:  BoxDecoration(
                      color: Style.VKNGGron,
                       borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0))
                  ),
                ),
              ),
            )),
            
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        validator: (String? value) {
                          return (value == null || !value.contains('@'))
                              ? 'debe tener @ .'
                              : null;
                        },
                        onSaved: (String? value) {},
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                                                                 Divider(color: Colors.grey,),

                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSaved: (String? value) {},
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'escribe una contraseña'
                                : null;
                          }),
                    ),
                                             Divider(color: Colors.grey,)

                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 12,
                ),
              ],
            ),
            Center(
              child: Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50), primary: Style.VKNGGron),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final loginDto = LoginDto(
                          email: emailController.text,
                          password: passwordController.text);
                      BlocProvider.of<LoginBloc>(context)
                          .add(DoLoginEvent(loginDto));
                    }
                  },
                  child: const Text('Login' , style: TextStyle(color:Colors.black),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
