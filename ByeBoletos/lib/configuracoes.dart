import 'package:ByeBoletos/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'helpers/DAO.dart';
import 'models/usuario.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  TimeOfDay horario;
  TextEditingController horarioCTL = TextEditingController(),
      usernameCTL = TextEditingController(),
      emailCTL = TextEditingController(),
      telefoneCTL = TextEditingController();
  final bd = DAO.instance;
  Usuario usuario;
  bool first = true;

  void initState() {
    setState(() {
      returnUsuario().then((value) {
        print(value);
        if (value.length > 0)
          setState(() {
            usuario = Usuario.fromMap(value[0]);
          });
      });
    });
  }

  Future<List<Map<String, dynamic>>> returnUsuario() async {
    return await bd.selectUsuario();
  }

  @override
  Widget build(BuildContext context) {
    if (usuario != null) {
      first = false;
      usernameCTL.text = usuario.USERNAME;
      emailCTL.text = usuario.EMAIL;
      telefoneCTL.text = usuario.TELEFONE;
      horarioCTL.text =
          '${usuario.HORARIOPREFERIDO.hour}:${usuario.HORARIOPREFERIDO.minute}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage())),
        ),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: usernameCTL,
                  decoration: InputDecoration(
                      icon: Icon(Icons.alternate_email),
                      hintText: 'Qual o seu username?',
                      labelText: 'Nome de usuário'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailCTL,
                  validator: (value) => EmailValidator.validate(value)
                      ? null
                      : "Entre um email válido",
                  decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Qual o seu email?',
                      labelText: 'E-mail'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: telefoneCTL,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    TelefoneInputFormatter()
                  ],
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: 'Qual o seu telefone?',
                      labelText: 'Telefone'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: horarioCTL,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((horaSelecionada) {
                      setState(() {
                        horario = horaSelecionada;
                        horarioCTL.text =
                            '${horaSelecionada.hour}:${horaSelecionada.minute}';
                      });
                    });
                  },
                  decoration: InputDecoration(
                      icon: Icon(Icons.access_alarms_outlined),
                      hintText: 'Escolha o melhor horário para notificações',
                      labelText: 'Melhor horário para notificações'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      usuario = Usuario(
                          EMAIL: emailCTL.text,
                          HORARIOPREFERIDO: horario,
                          TELEFONE: telefoneCTL.text,
                          USERNAME: usernameCTL.text);
                      if (first) {
                        bd.insertUsuario(usuario.toMap());
                      } else {
                        bd.updateUsuario(usuario.toMap());
                      }
                    } catch (e) {
                      /*Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Erro ao cadastrar usuário, tente novamente!'),
                      ));*/
                    } finally {
                      /* Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Usuário cadastrado com sucesso'),
                      ));*/
                    }
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
