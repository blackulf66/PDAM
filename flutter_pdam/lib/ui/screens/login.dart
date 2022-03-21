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
      body: Center(
        child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
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
      prefs.setString('nick' , late.nick);

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
        padding: const EdgeInsets.fromLTRB(24.0, 160.0, 24.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Center(child: SizedBox(
               child: Image.asset('assets/images/logo_miarmapp.png'))),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                  )
                ],
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(240, 50), primary: Colors.blue),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final loginDto = LoginDto(
                        email: emailController.text,
                        password: passwordController.text);
                    BlocProvider.of<LoginBloc>(context)
                        .add(DoLoginEvent(loginDto));
                  }
                },
                child: const Text('Login'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}