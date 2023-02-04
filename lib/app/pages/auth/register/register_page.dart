import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/delivery_app_bar.dart';
import '../../../core/ui/widgets/delivery_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
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
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirma Senha'),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: DeliveryButton(
                  label: 'Cadastrar',
                  onPressed: () {},
                  width: double.infinity,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
