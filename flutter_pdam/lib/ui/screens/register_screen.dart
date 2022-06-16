import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
import '../../bloc/loginbloc/bloc/login_bloc.dart';
import '../../bloc/registerbloc/bloc/register_bloc.dart';
import '../../constants.dart';
import '../../models/auth/register_dto.dart';
import '../../models/auth/register_response.dart';
import '../../repository/authrepository/auth_repository.dart';
import '../../repository/authrepository/auth_repository_impl.dart';
import 'login.dart';
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
      prefs.setString('id', late.userId);
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
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage('https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/06d20874-f823-4eb0-8b93-2b9f4aa85518/denu4za-c6b070ae-c0ee-4d5b-872d-f4383cf011c8.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzA2ZDIwODc0LWY4MjMtNGViMC04YjkzLTJiOWY0YWE4NTUxOFwvZGVudTR6YS1jNmIwNzBhZS1jMGVlLTRkNWItODcyZC1mNDM4M2NmMDExYzgucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.c0OLccCwziYNp_dRaqL-ymIj2OmkMUPASTtp_TOH208' ),
                            ),
                          color: Style.VKNGGron,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                    ),
                  ),
                )),
                Padding(
              padding: const EdgeInsets.only(bottom:30.0),
              child: Center(child: Text("Weekly bugle", style: TextStyle(color: Style.VKNGGron , fontSize: 20,),)),
            ),
            Center(
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                          color: Style.VKNGGron,
                          borderRadius: BorderRadius.circular(20)),
                child: new Row(
                 children: <Widget>[
              Expanded(
                child: Container(),
                ),
              InkWell(
                  splashColor: Colors.pinkAccent,
                child: new Container(
                  color: Colors.transparent,
                  child: new Text(
                    "login",
                    style: new TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  
                ),
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
              ),
              new Expanded(
                child: Container(),
              ),
              InkWell(
                 splashColor: Colors.pinkAccent,
                child: Container(
                  color: Colors.transparent,
                  child: new Text(
                    "signup",
                    style: new TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                
                ),
                onTap: () {
                    
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
                padding: const EdgeInsets.all(10.0),
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
                              style: TextStyle(
                            color: Colors.white
                          ),
                              controller: username,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24.0,
                            semanticLabel:
                                'person',
                          ),
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
                            style: TextStyle(
                            color: Colors.white
                          ),
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 24.0,
                            semanticLabel:
                                'email',
                          ),
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
                        height: 20,
                      ),
                     
                           Container(
                         decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                          child: TextFormField(
                            style: TextStyle(
                            color: Colors.white
                          ),
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 24.0,
                            semanticLabel:
                                'password',
                          ),
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
                                  prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 24.0,
                            semanticLabel:
                                'fecha',
                          ),
                                  hintStyle: TextStyle(color: Style.LetraColor),
                                  errorStyle: TextStyle(color: Colors.redAccent),
                                  suffixIcon: Icon(Icons.calendar_today),
                                  labelText: 'fecha de nacimiento',
                                  labelStyle: TextStyle(color:Style.LetraColor)
                                ),
                                mode: DateTimeFieldPickerMode.date,
                                autovalidateMode: AutovalidateMode.always,
                                validator: (e) => (e?.year ?? 0) >= 2003
                                    ? 'necesitas ser mayor de edad'
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
                          password: passwordController.text,
                          role:'USER');

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