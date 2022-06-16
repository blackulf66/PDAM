import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdamfinal/bloc/subpost/bloc/subpost_bloc.dart';
import 'package:pdamfinal/repository/postRepository/post_repository_impl.dart';
import 'package:pdamfinal/repository/subpostRepository/subpost_repository_impl.dart';
import 'package:pdamfinal/ui/screens/ErrorPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../bloc/image_pick_bloc/bloc/image_pick_bloc.dart';
import '../../bloc/post/postbloc/bloc/post_bloc.dart';
import '../../constants.dart';
import '../../models/post/post_dto.dart';
import '../../models/post/post_response.dart';
import '../../models/subpost/Subpost_response.dart';
import '../../repository/postRepository/post_repository.dart';
import '../../repository/subpostRepository/subpost_repository.dart';
import 'menu_screen.dart';

class formScreen extends StatefulWidget {
  formScreen({Key? key}) : super(key: key);

  @override
  _formScreenState createState() => _formScreenState();
}

class _formScreenState extends State<formScreen> {
  String imageSelect = "no tienes imagen ";
  FilePickerResult? result;
  PlatformFile? file;
  final _imagePicker = ImagePicker();

  String date = "";
  DateTime selectedDate = DateTime.now();

  late PostApiRepository _postRepository;
  late SubPostApiRepository _subpostRepository;

  final _formKey = GlobalKey<FormState>();
  TextEditingController nombre = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController subpost = TextEditingController();
  String dropDownValue = 'MARVEL';
  late Future<SharedPreferences> _prefs;
  final String uploadUrl = 'http://10.0.2.2:8080/auth/register';
  String path = "";
  bool _passwordVisible = false;

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _passwordVisible = false;
    _postRepository = PostApiRepositoryImpl();
    _subpostRepository = SubPostApiRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ImagePickBlocBloc();
            },
          ),
          BlocProvider(
            create: (context) {
              return PostBloc(_postRepository);
            },
          ),
          BlocProvider(
            create: (context) {
              return SubPostBloc(_subpostRepository);
            },
          ),
        ],
        child: _createBody(context),
      ),
    );
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(20),
            child:
                BlocConsumer<PostBloc, PostState>(listenWhen: (context, state) {
              return state is PostSuccessState || state is PostErrorState;
            }, listener: (context, state) async {
              if (state is PostSuccessState) {
                _loginSuccess(context, state.loginResponse);
              } else if (state is PostErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is BlocPostInitial || state is PostLoading;
            }, builder: (ctx, state) {
              if (state is BlocPostInitial) {
                return _post(ctx);
              } else if (state is PostLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _post(ctx);
              }
            })),
      ),
    );
  }

  Future<void> _loginSuccess(BuildContext context, PostApiResponse late) async {
    _prefs.then((SharedPreferences prefs) {
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

  _post(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'nueva noticia:',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          style:TextStyle(color: Colors.white),
                          controller: nombre,
                          decoration: InputDecoration(
                        
                            hintText: 'nombre',
                            hintStyle: TextStyle(color: Color.fromARGB(190, 255, 255, 255)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: TextFormField(
                            style:TextStyle(color: Colors.white),
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: descripcion,
                            decoration: InputDecoration(
                              hintText: 'descripcion',
                              hintStyle: TextStyle(color: Color.fromARGB(190, 255, 255, 255)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                                        height: MediaQuery.of(context).size.height / 2,
                                        width: MediaQuery.of(context).size.height / 3 ,
                                      ),
                                    
                                  ]);
                                }
                                return Row(
                                  
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Center(
                                        child: Row(
                                          children: [
                                           Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          child: Icon(Typicons.upload ,color: Colors.white,),
                                           onTap: () {
                                                      BlocProvider.of<
                                                                  ImagePickBlocBloc>(
                                                              context)
                                                          .add(const SelectImageEvent(
                                                              ImageSource.gallery));
                                                    },
                                        ),
                                      ),
                                    ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                'Seleccionar Imagen',
                                                style:
                                                    TextStyle(color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          child: Icon(Typicons.camera ,color: Colors.white,),
                                           onTap: () {
                                                      BlocProvider.of<
                                                                  ImagePickBlocBloc>(
                                                              context)
                                                          .add(const SelectImageEvent(
                                                              ImageSource.camera));
                                                    },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                'haz la foto',
                                                style:
                                                    TextStyle(color: Colors.white),
                                              ),
                                            )
                                  ],
                                );
                              }),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: DecoratedBox(
                            
                            decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                value: dropDownValue,
                                icon: const Icon(Icons.arrow_downward , color: Colors.black,),
                                elevation: 0,
                                style: const TextStyle(color: Color.fromARGB(255, 85, 255, 244)),
                                underline: Container(
                                  height: 2,
                                  color: Colors.transparent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropDownValue = newValue!;
                                  });
                                },
                                items: <String>['MARVEL', 'DC'] 
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(value, style: TextStyle(color: Colors.black),),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //  Padding(
                      //       padding: const EdgeInsets.only(top:8.0),
                      //       child: Container(
                      //          width: MediaQuery.of(context).size.width,

                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(14.0),
                      //           border: Border.all(
                      //               color: Colors.grey,
                      //               width: 1,
                      //             ),
                      //         ),
                      //         child: TextFormField(

                      //           controller: subpost,
                      //           decoration: InputDecoration(
                      //             hintText: 'nombre subpost',
                      //             hintStyle: TextStyle(color: Colors.grey),
                      //             border: OutlineInputBorder(
                      //               borderSide: BorderSide.none,
                      //             ),
                      //           ),
                      //         ),)),

                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(240, 50),
                                primary: Style.VKNGGron),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (_formKey.currentState!.validate()) {
                                final loginDto = PostDto(
                                    nombre: nombre.text,
                                    descripcion: descripcion.text,
                                    subpost: dropDownValue);
                                BlocProvider.of<PostBloc>(context)
                                    .add(DoPostEvent(loginDto, path));
                              }
                              prefs.setString('nombre', nombre.text);
                              prefs.setString('descripcion', descripcion.text);
                              prefs.setString('subpost', dropDownValue);
                            },
                            child: const Text('subir'),
                          ),
                        ),
                      ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _subPostItem(BuildContext context, SubPostApiResponse subpost) {
    return Text(subpost.nombre);
  }
}
