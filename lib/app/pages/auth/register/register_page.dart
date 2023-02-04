import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/delivery_app_bar.dart';
import '../../../core/ui/widgets/delivery_button.dart';
import 'register_controller.dart';
import 'register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: hideLodaer,
          register: showLodaer,
          error: () {
            hideLodaer();
            messageError('Erro ao registrar o usuário');
          },
          success: () {
            hideLodaer();
            messageSuccess('Cadstro relizado com sucesso');
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style: context.textStyles.textTitle,
                  'Cadastro',
                ),
                Text(
                  'Preencha os campos abaixo para criar o seu cadastro.',
                  style: context.textStyles.textMedium.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: Validatorless.required('Nome Obrigatório'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _emailEC,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordEC,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatório'),
                    Validatorless.min(
                        6, 'Senha deve conter pelo menos 6 letras'),
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Confirma Senha'),
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirma Senha obrigatório'),
                    Validatorless.compare(
                        _passwordEC, "Senhas devem ser iguais")
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: DeliveryButton(
                    label: 'Cadastrar',
                    onPressed: () {
                      final valid = _formKey.currentState?.validate() ?? false;

                      if (valid) {
                        controller.register(
                          _nameEC.text,
                          _emailEC.text,
                          _passwordEC.text,
                        );
                      }
                    },
                    width: double.infinity,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
