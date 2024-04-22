import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const TelaLogin());
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class MyComboBox extends StatefulWidget {
  final Function(String?)? onChanged;

  const MyComboBox({Key? key, this.onChanged}) : super(key: key);

  @override
  _MyComboBoxState createState() => _MyComboBoxState();
}

class _MyComboBoxState extends State<MyComboBox> {
  String? _selectedItem;

  List<String> _items = [
    'Curso',
    'Engenharia de Software',
    'Análise e Desenvolvimento de Sistemas',
    'Psicologia',
    'Direito'
  ];

  @override
  void initState() {
    super.initState();
    _selectedItem = 'Curso';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 88, 108, 44)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: DropdownButton<String>(
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.01,
            ),
            isExpanded: true,
            value: _selectedItem,
            onChanged: (String? value) {
              setState(() {
                _selectedItem = value;
                widget.onChanged?.call(value);
              });
            },
            itemHeight: 55,
            items: _items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 96, 108, 44),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveForm = GlobalKey<FormState>();
  var _modoLogin = true;
  var _emailInserido = '';
  var _senhaInserida = '';
  var _nomeUsuarioInserido = '';
  var _raInserido = '';
  var _cursoInserido = '';
  var _turmaInserida = '';
  String? _cursoSelecionado;
  String? _cursoError;

  void _enviar() async {
    if (!_chaveForm.currentState!.validate()) {
      return;
    }

    _chaveForm.currentState!.save();

    if (_cursoInserido == 'Curso') {
      setState(() {
        _cursoError = 'Por favor, selecione uma opção';
      });
      return;
    } else {
      setState(() {
        _cursoError = null;
      });
    }

    _chaveForm.currentState!.save();

    try {
      if (_modoLogin) {
        //logar usuario
        print('Usuário Logado. Email: $_emailInserido, Senha: $_senhaInserida');
      } else {
        //criar usuario
        print(
            'Usuário Criado. Email: $_emailInserido, Senha: $_senhaInserida, Nome de Usuário: $_nomeUsuarioInserido');
      }
    } catch (_) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha na autenticação.'),
        ),
      );
    }
  }

  String? _validateComboBox(String? value) {
    if (value == null || value == 'Curso') {
      return 'Por favor, selecione uma opção';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.,
        body: Center(
          // padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 88, 108, 44),
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft: Radius.circular(200),
                          //   bottomRight: Radius.circular(200),
                          // ),
                        ),
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 150.0,
                              maxHeight: 150.0,
                            ),
                            width: 150.0,
                            height: 150.0,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('assets/Sem título.png'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width > 600
                                ? 100.0
                                : 20.0,
                            horizontal: MediaQuery.of(context).size.width > 600
                                ? 100.0
                                : 20.0),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: _chaveForm,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (!_modoLogin)
                                    TextFormField(
                                      cursorColor: const Color.fromARGB(
                                          255, 96, 108, 44),
                                      decoration: const InputDecoration(
                                        labelText: 'Nome completo',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 96, 108, 44),
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 88, 108, 44),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 26, 70, 27))),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      enableSuggestions: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z\s]')),
                                      ],
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.trim().length < 4) {
                                          return 'Por favor, insira pelo menos 4 caracteres.';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _nomeUsuarioInserido = value!;
                                      },
                                    ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    cursorColor:
                                        const Color.fromARGB(255, 96, 108, 44),
                                    decoration: const InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 96, 108, 44),
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 88, 108, 44),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 26, 70, 27))),
                                        fillColor: Colors.white,
                                        filled: true),
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    textCapitalization: TextCapitalization.none,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty ||
                                          !value.contains('@')) {
                                        return 'Por favor, insira um endereço de email válido.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _emailInserido = value!;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    cursorColor:
                                        const Color.fromARGB(255, 96, 108, 44),
                                    decoration: const InputDecoration(
                                        labelText: 'Senha',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 96, 108, 44),
                                            fontWeight: FontWeight.bold),
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 88, 108, 44),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 26, 70, 27)),
                                        )),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().length < 6) {
                                        return 'A senha deve ter pelo menos 6 caracteres.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _senhaInserida = value!;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  if (!_modoLogin)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                cursorColor:
                                                    const Color.fromARGB(
                                                        255, 96, 108, 44),
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'RA',
                                                  labelStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 96, 108, 44),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 88, 108, 44),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          26,
                                                                          70,
                                                                          27))),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  counterText: '',
                                                ),
                                                maxLength: 10,
                                                enableSuggestions: false,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                ],
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      value.trim().length < 4) {
                                                    return 'Por favor, insira pelo menos 4 caracteres.';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {
                                                  _raInserido = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(child:
                                                MyComboBox(onChanged: (value) {
                                              setState(() {
                                                _cursoInserido = value!;
                                              });
                                            }))
                                          ],
                                        ),
                                        if (_cursoError !=
                                            null) // Exibe a mensagem de erro se houver algum erro no curso
                                          Text(
                                            _cursoError!,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                cursorColor:
                                                    const Color.fromARGB(
                                                        255, 96, 108, 44),
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Turma',
                                                  labelStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 96, 108, 44),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 88, 108, 44),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          26,
                                                                          70,
                                                                          27))),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                ),
                                                enableSuggestions: false,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'[a-zA-Z\s]')),
                                                ],
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      value.trim().length < 4) {
                                                    return 'Por favor, insira pelo menos 4 caracteres.';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {
                                                  _turmaInserida = value!;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    height: 48.0,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: _enviar,
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color.fromARGB(
                                                      255, 224, 148, 12)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)))),
                                      child: Text(
                                          _modoLogin ? 'Entrar' : 'Cadastrar',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Wrap(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _modoLogin = !_modoLogin;
                                          });
                                        },
                                        child: Text(
                                          _modoLogin
                                              ? 'Não possui cadastro? '
                                              : 'Já possuo cadastro, ',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _modoLogin = !_modoLogin;
                                          });
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text(
                                            _modoLogin
                                                ? 'Criar conta'
                                                : 'Entrar',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 26, 70, 27),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
