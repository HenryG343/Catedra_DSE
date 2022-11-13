import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'usuarios.api.dart';
import 'lector.dart';

void main() => runApp(MainMaterial());

class MainMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

//Variables globales
final duiController = TextEditingController();
final passController = TextEditingController();
List<String> sesion = new List();
int _idRecuperado = -2;
String error = '';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => LoginScreen(),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textDUI = new TextEditingController();
  TextEditingController textContra = new TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final _iconSize = MediaQuery.of(context).size.width * 0.1;
    final _margin = MediaQuery.of(context).size.width * 0.08;
    final _padding = MediaQuery.of(context).size.width * 0.02;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.05,
                0.3,
                0.6,
                0.8
              ],
                  colors: [
                Colors.grey,
                Colors.grey[400],
                Colors.grey[400],
                Colors.grey,
              ])),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: _buildTextContainer(
                      _margin,
                      _padding,
                      _buildTextForm(
                          _iconSize,
                          'Ingrese su DUI',
                          'Ingrese solo numeros',
                          false,
                          TextInputType.number,
                          duiController,
                          Icons.account_box_outlined,
                          9)),
                ),
                Flexible(
                  child: _buildTextContainer(
                      _margin,
                      _padding,
                      _buildTextForm(
                          _iconSize,
                          'Ingrese su Contraseña',
                          '',
                          true,
                          TextInputType.text,
                          passController,
                          Icons.lock,
                          8)),
                ),
                Flexible(
                  child: _buildTextContainer(
                    _margin,
                    _padding,
                    OutlinedButton(
                      onPressed: () {
                        Login(_iconSize * 0.5);
                      },
                      child: Text(
                        'Iniciar Sesion',
                        style: TextStyle(fontSize: _iconSize * 0.5),
                      )
                    ),
                  ),
                ),
                Flexible(
                  child: _buildTextContainer(
                    _margin,
                    _padding,
                    OutlinedButton(
                      onPressed: () {
                        _buildSalirAlert(context);
                      },
                      child: Text(
                        'Salir',
                        style: TextStyle(fontSize: _iconSize * 0.5),
                      ),
                      // textColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextForm(
      double iconSize,
      String label,
      String helper,
      bool hidden,
      TextInputType type,
      TextEditingController controller,
      IconData icon,
      int longitud) {
    return TextFormField(
      validator: (text) {
        if (text.length == 0) {
          return "Este campo requerido";
        }
        return null;
      },
      controller: controller,
      keyboardType: type,
      obscureText: hidden,
      initialValue: null,
      maxLength: longitud,
      decoration: InputDecoration(
        icon: Icon(icon, size: iconSize),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        helperText: helper,
        suffixIcon: Icon(
          Icons.check_circle,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6200EE)),
        ),
      ),
    );
  }

  Future<void> recuperarUsuario(String dui, String pass) async {
    String data = await login(dui, pass);
    sesion = new List();
    if (data != null) {
      print('Data recuperada: ' + data.toString());
      sesion = data.split(';');
      print('Longitud de la lista: ' + sesion.length.toString());
      setState(() {
        _idRecuperado = int.parse(sesion[2]);
      });
      print('ID Con sesion exitosa: ' + _idRecuperado.toString());
    } else {
      if (data == null) {
        setState(() {
          _idRecuperado = -1;
        });
      } else {
        sesion = new List();
        sesion = data.split(';');
        setState(() {
          _idRecuperado = -2;
        });
      }
      sesion = new List();
      for (String s in sesion) {
        print('OnFail: Sesion ' + s);
      }
      print('ID con error: ' + _idRecuperado.toString());
    }
  }

  Widget _buildTextContainer(double margin, double padding, Widget widget) {
    return Container(
        margin:
            EdgeInsets.symmetric(horizontal: margin, vertical: margin * 0.5),
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        child: widget);
  }

  _buildAlertDialog(String title, String detail, BuildContext context, int id) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(detail),
      actions: [
        OutlinedButton(
            child: Text('Continuar'),
            onPressed: () {
              if (id > 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LectorMain(
                              id_usuario: _idRecuperado,
                            )));
                setState(() {
                  sesion = new List();
                  //_idRecuperado = 0;
                });
              } else {
                Navigator.pop(context);
              }
            }),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Login(double _font) {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      try {
        var dui = duiController.text;
        var pass = passController.text;
        showLoadingAlertDialog(context,_font);
        recuperarUsuario(dui, pass).whenComplete(() {
          print("ID: " + _idRecuperado.toString());
          Navigator.pop(context);
          if (_idRecuperado > 0) {
            print('Sesion Exitosa');
            _buildAlertDialog(
                'Inicio de Sesion', 'Bienvenido', context, _idRecuperado);
          } else if (_idRecuperado == -1) {
            print('Sesion Fallida');
            _buildAlertDialog('Inicio de Sesion',
                'Error: Usuario(DUI) o Contraseña incorrecto', context, -1);
          } else {
            print('No hay conexion con el servidor');
            _buildAlertDialog('Inicio de Sesion',
                'Ha ocurrido un error con el servidor', context, -1);
          }
        });
      } catch (ex) {
        print(ex.toString());
      }
    }
  }

  _buildSalirAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Salir'),
      content: Text('¿Desea salir de la aplicación?'),
      actions: [
        OutlinedButton(
            child: Text('Si'),
            onPressed: () {
              SystemNavigator.pop();
            }),
        OutlinedButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

//Circulo de carga
showLoadingAlertDialog(BuildContext context, double texSize) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 5), child: Text("Iniciando Sesion",style: TextStyle(fontSize: texSize),)),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
