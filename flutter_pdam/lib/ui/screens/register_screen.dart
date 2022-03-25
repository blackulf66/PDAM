import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/bloc/loginbloc/bloc/login_bloc.dart';
import 'package:flutter_application_1/ui/screens/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:date_field/date_field.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/image_pick_bloc/bloc/image_pick_bloc.dart';
import '../../bloc/registerbloc/bloc/register_bloc.dart';
import '../../constants.dart';
import '../../models/auth/register_dto.dart';
import '../../models/auth/register_response.dart';
import '../../repository/authrepository/auth_repository.dart';
import '../../repository/authrepository/auth_repository_impl.dart';
import 'menu_screen.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String imageSelect = "Imagen no selecionada";
  FilePickerResult? result;
  PlatformFile? file;
  final _imagePicker = ImagePicker();
  bool _passwordVisible = false;


  String date = "";
  DateTime selectedDate = DateTime.now();

  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fechaNacimiento = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late Future<SharedPreferences> _prefs;
  final String uploadUrl = 'http://10.0.2.2:8080/auth/register';
  String path = "";

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _prefs = SharedPreferences.getInstance();
    _passwordVisible = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ImagePickBlocBloc();
            },
          ),
          BlocProvider(
            create: (context) {
              return RegisterBloc(authRepository);
            },
          ),
        ],
        child: _createBody(context),
      ),
    );
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Container(
            padding: const EdgeInsets.all(0),
            child: BlocConsumer<RegisterBloc, RegisterState>(
                listenWhen: (context, state) {
              return state is RegisterSuccessState || state is LoginErrorState;
            }, listener: (context, state) async {
              if (state is RegisterSuccessState) {
                _loginSuccess(context, state.registerResponse);
              } else if (state is LoginErrorState) {
                _showSnackbar(context, "error");
              }
            }, buildWhen: (context, state) {
              return state is RegisterInitialState ||
                  state is RegisterLoadingState;
            }, builder: (ctx, state) {
              if (state is RegisterInitialState) {
                return _register(ctx);
              } else if (state is RegisterLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _register(ctx);
              }
            })),
      
    );
  }

  Future<void> _loginSuccess(
      BuildContext context, RegisterResponse late) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString('token', late.email);
      prefs.setString('id', late.id);
      prefs.setString('avatar', late.avatar);

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

  _register(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  const Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Center(
                  child: SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Style.VKNGGron,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                    ),
                  ),
                )),
            Center(
              child: Container(
                height: 30,
                width: 300,
                decoration: BoxDecoration(
                          color: Style.VKNGGron,
                          borderRadius: BorderRadius.circular(20)),
                child: new Row(
                 children: <Widget>[
              Expanded(
                child: Container(),
                ),
              new RaisedButton(
                splashColor: Colors.pinkAccent,
                color: Colors.transparent,
                child: new Text(
                  "login",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
              new Expanded(
                child: Container(),
              ),
              RaisedButton(
                splashColor: Colors.pinkAccent,
                color: Colors.transparent,
                child: new Text(
                  "signup",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              onPressed: () {
                  
}
              ),
              new Expanded(
                child: Container(),
              ),
            ],
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                            child: TextFormField(
                              controller: username,
                              decoration: InputDecoration(
                                hintText: 'username',
                                hintStyle: TextStyle(color: Style.LetraColor),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                           Divider(
                      color: Colors.grey,
                    ),
                      Padding(
                        padding: const EdgeInsets.only(top:20),
                        child: Container(
                           decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Style.LetraColor),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                       Divider(
                      color: Colors.grey,
                    ),
                      SizedBox(
                        height: 32,
                      ),
                     
                           Container(
                         decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                             hintText: 'Password',
                            hintStyle: TextStyle(color:Style.LetraColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey  ,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              
                            ),
                          ),
                        ),
                      Divider(
                      color: Colors.grey,
                    ),

                     Padding(
                            padding: const EdgeInsets.only(top:20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                               decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                              child: DateTimeFormField(
                                initialDate: DateTime(2000, 10, 11),
                                firstDate: DateTime.utc(1900),
                                lastDate: DateTime.now(),
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Style.LetraColor),
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  suffixIcon: Icon(Icons.calendar_today),
                                  labelText: 'fecha de nacimiento',
                                  labelStyle: TextStyle(color:Style.LetraColor)
                                ),
                                mode: DateTimeFieldPickerMode.date,
                                autovalidateMode: AutovalidateMode.always,
                                validator: (e) => (e?.day ?? 0) == 1
                                    ? 'Please not the first day'
                                    : null,
                                onDateSelected: (DateTime value) {
                                  selectedDate = value;
                                  print(value);
                                },
                              ),
                            ),
                          ),

                           Divider(
                      color: Colors.grey,
                    ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<ImagePickBlocBloc, ImagePickBlocState>(
                          listenWhen: (context, state) {
                            return state is ImageSelectedSuccessState;
                          },
                          listener: (context, state) {},
                          buildWhen: (context, state) {
                            return state is ImagePickBlocInitial ||
                                state is ImageSelectedSuccessState;
                          },
                          builder: (context, state) {
                            if (state is ImageSelectedSuccessState) {
                              path = state.pickedFile.path;
                              print('PATH ${state.pickedFile.path}');
                              return Column(children: [
                                Image.file(
                                  File(state.pickedFile.path),
                                  height: 100,
                                ),
                               
                              ]);
                            }
                            return Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50), primary: Style.VKNGGron),
                                    onPressed: () {
                                      BlocProvider.of<ImagePickBlocBloc>(context)
                                          .add(const SelectImageEvent(
                                              ImageSource.gallery));
                                    },
                                    child: const Text('Select Image')));
                          })
                    ],
                  ),
                ),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50), primary: Style.VKNGGron),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (_formKey.currentState!.validate()) {
                      final loginDto = RegisterDto(
                          username: username.text,
                          email: emailController.text,
                          password: passwordController.text,);

                      BlocProvider.of<RegisterBloc>(context)
                          .add(DoRegisterEvent(loginDto, path));
                    }
                    prefs.setString('username', username.text);
                    prefs.setString('email', emailController.text);
                    prefs.setString('fechaNacimiento',
                        DateFormat("yyyy-MM-dd").format(selectedDate));
                    prefs.setString('password', passwordController.text);

                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Register'),
                ),
              ),
              SizedBox(
                height: 24,
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
      ),
    );
  }
}