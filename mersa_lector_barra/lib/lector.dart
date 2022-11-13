import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mersa_lector_barra/series.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'series.api.dart';

//void main() => runApp(MaterialApp(home: LectorMain(-1)));

class LectorMain extends StatefulWidget {
  final int id_usuario;
  const LectorMain({
    this.id_usuario,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LectorState();
}

class _LectorState extends State<LectorMain> {
  var qrText = '';
  QRViewController controller;
  bool habilidato = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  List<DropdownMenuItem<String>> items = new List();
  String _placa;
  //Lista de series escaneadas
  List<String> seriesScan = new List();
  //Lista de series del sac
  List<String> seriesSac = new List();
  //Lista de clase series
  List<Series> seriesPost = new List();
  @override
  void initState() {
    seriesScan = new List();
    super.initState();
    print('Cargando Placas');
    CargarPlacas();
    print('Cargando Series SAC');
    // CargarSeriesSac();
  }

  void CargarPlacas() async {
    await recuperarPlacas();
    setState(() {});
  }

  // void CargarSeriesSac() async {
  //   await recuperarSeriesSac();
  //   print('Recuperando series sac');
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final _cameraViewAreaWidth = MediaQuery.of(context).size.width * 0.60;
    final _iconSize = MediaQuery.of(context).size.width * 0.1;
    final _margin = MediaQuery.of(context).size.width * 0.08;
    final _marginList = MediaQuery.of(context).size.width * 0.001;
    final _padding = MediaQuery.of(context).size.width * 0.02;
    final _paddingList = MediaQuery.of(context).size.width * 0.01;
    final _font = MediaQuery.of(context).size.width * 0.01;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 5,
                  borderLength: 50,
                  borderWidth: 5,
                  cutOutSize: _cameraViewAreaWidth * 1.1,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  children: <Widget>[
                    _buildTextContainer(
                      _margin,
                      _padding,
                      Text(
                        'El codigo escaneado es el siguiente: \n' + qrText,
                        style: TextStyle(fontSize: 6 * _font),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTextContainer(
                          _margin,
                          _padding,
                          Text('Placas:',
                              style: TextStyle(fontSize: 6 * _font)),
                        ),
                        _buildTextContainer(
                          _margin,
                          _padding,
                          new DropdownButton(
                              value: _placa,
                              items: items,
                              onChanged: changedDropDownItem,
                              style: TextStyle(
                                  fontSize: 6 * _font, color: Colors.black)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildTextContainer(
                          _margin,
                          _padding,
                          OutlinedButton(
                            onPressed: () {
                              try {
                                if (_placa == null) {
                                  _buildAlertDialog(
                                      'Error',
                                      'No ha seleccionado niguna placa',
                                      context);
                                } else {
                                  if (seriesScan.length <= 0) {
                                    _buildAlertDialog(
                                        'Error',
                                        'No ha escaneado niguna serie',
                                        context);
                                  } else {
                                    setState(() {
                                      limpiarRepetidas();
                                    });
                                    for (String s in seriesScan) {
                                      Series serieS = new Series();
                                      serieS.serie = s;
                                      serieS.id_usuario = widget.id_usuario;
                                      serieS.placa = _placa;
                                      seriesPost.add(serieS);
                                    }
                                    showLoadingAlertDialog(
                                        context, _iconSize * 0.5);
                                    RealizarPostLista(seriesPost)
                                        .whenComplete(() {
                                      Navigator.pop(context);
                                      _buildAlertDialog(
                                          'Agregando serie',
                                          'Las series escaneadas han sido guardadas ',
                                          context);
                                      setState(() {
                                        seriesScan.clear();
                                        seriesScan = new List();
                                        seriesPost.clear();
                                        seriesPost = new List();
                                        qrText = '';
                                      });
                                    }).catchError((error, stackTrace) {
                                      Navigator.pop(context);
                                      _buildAlertDialog(
                                          'Error',
                                          'Ha ocurrido el error +$error',
                                          context);
                                    });
                                  }
                                }
                              } on Exception catch (e) {
                                Navigator.pop(context);
                                _buildAlertDialog('Excepción',
                                    'Se ha producido una excepción', context);
                              }
                            },
                            child: Text('Finalizar Scan',
                                style: TextStyle(fontSize: _iconSize * 0.5)),
                          ),
                        ),
                        _buildTextContainer(
                          _margin,
                          _padding,
                          OutlinedButton(
                            onPressed: () {
                              _buildSalirAlert(context);
                            },
                            child: Text('Salir',
                                style: TextStyle(fontSize: _iconSize * 0.5)),
                          ),
                        ),
                      ],
                    ),
                    _buildTextContainer(
                      _margin,
                      _padding,
                      OutlinedButton(
                        onPressed: () {
                          controller.pauseCamera();
                          controller.resumeCamera();
                        },
                        child: Text('Act. Cam',
                            style: TextStyle(fontSize: _iconSize * 0.5)),
                      ),
                    ),
                    // _buildTextContainer(
                    //   _margin,
                    //   _padding,
                    //   OutlinedButton(
                    //     onPressed: () {
                    //       CargarSeriesSac();
                    //     },
                    //     child: Text('Actualizar',
                    //         style: TextStyle(fontSize: _iconSize * 0.5)),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _buildListView(seriesScan, context, _marginList,
                  _paddingList, _iconSize * 0.5),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print("Antes de imprimir scan data");
        print(scanData.code);
        qrText = scanData.code;
        seriesScan.add(qrText);
      });
      controller.pauseCamera();
      Timer(Duration(seconds: 3), () {
        controller.resumeCamera();
      });
    });
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   Barcode result;
  //   setState(() {
  //     this.controller = controller;
  //   });
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //     });
  //     print(result.code);
  //   });
  // }

//Metodo para liberar los recursos de la camara
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

//Metodo que se manda a llamar cuando se hace un cambio en la eleccion del dropdown
  void changedDropDownItem(String value) {
    setState(() {
      _placa = value;
    });
  }

//Metodo para limpiar elementos repetidos de una lista
  void limpiarRepetidas() {
    int index = 0;
    List<String> salida = List();
    seriesScan.forEach((u) {
      if (salida.contains(u)) {
      } else {
        salida.add(u);
      }
    });
    setState(() {
      seriesScan = salida;
    });
  }

//Metodo Future para recuperar las placas enviadas por el web service
  //Debe ser future void para que pueda ser utilizada fuera de algun constructor Future
  Future<void> recuperarPlacas() async {
    List<String> data = await placas();
    items = new List();
    print('Longitud de la lista: ' + data.length.toString());
    for (String s in data) {
      items.add(new DropdownMenuItem(value: s, child: new Text(s)));
    }
  }

  //Metodo Future para recupear las series enviadas por el web service para la bdd SAC
  Future<void> recuperarSeriesSac() async {
    List<String> data = await seriesSacService();
    seriesSac = new List();
    print('Longitud de la lista de series sac: ' + data.length.toString());
    for (String s in data) {
      seriesSac.add(s.trim());
    }
  }

//Widget que construye una caja con margenes, padding y que recibe como parametro un widget para renderizarlo como hijo
  //del widget Container
  Widget _buildTextContainer(double margin, double padding, Widget widget) {
    return Container(
        margin:
            EdgeInsets.symmetric(horizontal: margin, vertical: margin * 0.5),
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        child: widget);
  }

//Construye donde se renderiza la lista de series escaneadas
  Widget _buildListView(List<String> lista, BuildContext context, double margin,
      double padding, double _fontsize) {
    return ListView(
      children: _buildGestureDetector(lista, margin, padding, _fontsize),
    );
  }

//Metodo que construye un GestureDetector, el cual en este caso es el tap
  //para poder realizar una accion segun el gesto, a forma de un tipo boton, pero bajo un evento touch especifico
  List<Widget> _buildGestureDetector(
      List<String> lista, double _margin, double _padding, double _fontsize) {
    List<Widget> listaWid = [];
    setState(() {
      limpiarRepetidas();
    });

    for (int i = 0; i < lista.length; i++) {
      listaWid.add(
        GestureDetector(
          onTap: () {
            _buildEliminarAlert(context, i);
          },
          child: _buildTextContainer(
            _margin,
            _padding,
            Text(
              'Serie: ' + lista[i],
              style: TextStyle(color: Colors.black, fontSize: _fontsize * 0.5),
            ),
          ),
        ),
      );
    }

    return listaWid;
  }

//Similar a las MessageBox, Construye una ventana de alerta, el cual se puede personalizar el mensaje y el titulo
  // de la alerta
  _buildAlertDialog(String title, String detail, BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(detail),
      actions: [
        OutlinedButton(
            child: Text('Continuar'),
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

//Constructor de alerta especificamente para cuando se eliminan las series del Gesto tap sobre ellas en la lista
  _buildEliminarAlert(BuildContext context, int serie) {
    AlertDialog alert = AlertDialog(
      title: Text('Eliminar'),
      content: Text('Desea eliminar la siguiente serie: ' + seriesScan[serie]),
      actions: [
        OutlinedButton(
            child: Text('Si'),
            onPressed: () {
              setState(() {
                seriesScan.removeAt(serie);
              });
              Navigator.pop(context);
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

//Constructor de ventana de alerta para cerra la aplicacion
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

  //Para validar si la serie pertenece
  // bool PerteneceSerie(String serie) {
  //   return seriesSac.contains(serie);
  // }

//Constructor del circulo de carga
  //Circulo de carga
  showLoadingAlertDialog(BuildContext context, double texSize) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                "Enviando Series",
                style: TextStyle(fontSize: texSize),
              )),
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
}

//Metodo que hace llamada asincrona al metodo que permite hacer el post de las series
//para el web service
Future<void> RealizarPostLista(List<Series> series) async {
  final String result = await createPostList(series);
}
