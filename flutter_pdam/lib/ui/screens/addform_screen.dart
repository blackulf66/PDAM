 import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdamfinal/repository/postRepository/post_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/image_pick_bloc/bloc/image_pick_bloc.dart';
import '../../bloc/postbloc/bloc/post_bloc.dart';
import '../../constants.dart';
import '../../models/post/post_dto.dart';
import '../../models/post/post_response.dart';
import '../../repository/postRepository/post_repository.dart';
import 'menu_screen.dart';
class formScreen extends StatefulWidget {
    
    formScreen({ Key? key }) : super(key: key);

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
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombre = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController subpost = TextEditingController();
  late Future<SharedPreferences> _prefs;
  final String uploadUrl = 'http://10.0.2.2:8080/auth/register';
  String path = "";
  List<String> comunidadesSeguidas = ['MARVEL', 'DC'];
  String dropdownvalue = 'MARVEL';
  bool _passwordVisible = false;

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _passwordVisible = false;
    _postRepository = PostApiRepositoryImpl();
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
            child: BlocConsumer<PostBloc, PostState>(
                listenWhen: (context, state) {
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

  Future<void> _loginSuccess(
      BuildContext context, PostApiResponse late) async {
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                        ),
                        child: TextFormField(
                          
                          controller: nombre,
                          decoration: InputDecoration(
                            hintText: 'nombre',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Container(
                           width: MediaQuery.of(context).size.width,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                          ),
                          child: TextFormField(
                            
                            controller: descripcion,
                            decoration: InputDecoration(
                              hintText: 'descripcion',
                              hintStyle: TextStyle(color: Colors.grey),
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
                                      height: 100,
                                    ),
                                  ]);
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Center(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: ElevatedButton(
                                            

                                              
                                                onPressed: () {
                                                  BlocProvider.of<ImagePickBlocBloc>(context)
                                                      .add(const SelectImageEvent(
                                                          ImageSource.gallery));
                                                },
                                                  style: ElevatedButton.styleFrom(
                                                  primary: Style.VKNGGron,
                                                       ),
                                               
                                                    child: Center(child: Icon(Icons.arrow_circle_up)),
                                                  
                                          
                                                )),
                                             Padding(
                                               padding: const EdgeInsets.only(left:15.0),
                                               child: Text('Seleccionar Imagen' ,style: TextStyle(color: Colors.white),),
                                             )

                                        ],
                                      ),
                                      ),
                                );
                              }),
                        ],
                      ),
                      /*Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 11),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: DropdownButton(
                        
                        value: dropdownvalue,
                        underline: Container(color: Colors.grey[200]),
                        dropdownColor: Colors.grey[200],
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                        items: comunidadesSeguidas
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    ),
                  ),*/
                   Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Container(
                           width: MediaQuery.of(context).size.width,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                          ),
                          child: TextFormField(
                            
                            controller: subpost,
                            decoration: InputDecoration(
                              hintText: 'nombre subpost',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),)),
                      
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
              Padding(
                padding: const EdgeInsets.only(top:80.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(240, 50), primary: Colors.grey),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (_formKey.currentState!.validate()) {
                        final loginDto = PostDto(
                            nombre: nombre.text,
                            descripcion: descripcion.text,
                            subpost: dropdownvalue);
                        BlocProvider.of<PostBloc>(context)
                            .add(DoPostEvent(loginDto, path));
                      }
                      prefs.setString('nombre', nombre.text);
                      prefs.setString('descripcion', descripcion.text);
                      prefs.setString('subpost', subpost.text);
                    },
                    child: const Text('subir'),
                  ),
                ),
              ),
              
            ],
          ),
          
        ),
        
      ),
    );
  }

}