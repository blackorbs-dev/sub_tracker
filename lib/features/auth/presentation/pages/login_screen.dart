import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_tracker/core/service/toast_manager.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/core/util/extensions.dart';
import 'package:sub_tracker/core/util/input_validator.dart';

import '../../../../router/routes.dart';
import '../../../shared/presentation/widgets/primary_button.dart';
import '../../../shared/presentation/widgets/svg_icon.dart';
import '../../../shared/presentation/widgets/text_field.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../bloc/login_bloc.dart';
import '../widgets/bottom_text.dart';
import '../widgets/header_box.dart';
import '../widgets/input_title.dart';
import '../widgets/scrollable_container.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(context.read()),
        child: const LoginView()
    );
  }

}

class LoginView extends StatefulWidget{
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => LoginViewState();

}

class LoginViewState extends State<LoginView>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ScrollableContainer(child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                  tag: 'header',
                  child: context.isMobile ? const HeaderBox()
                      : const HeaderTitle(text: 'Login')
              ),
              const Hero(
                  tag: 'email_title',
                  child: InputTitle(text: 'Email')
              ),
              Hero(tag: 'email_field', child: TextInputField(
                hint: 'Enter your email address',
                iconAssetName: 'assets/icons/mail.svg',
                validator: InputValidators.validateEmail,
                inputType: TextInputType.emailAddress,
                onChanged: (value){
                  context.read<LoginBloc>().add(EmailChanged(value));
                },
              )),
              const Hero(
                  tag: 'password_title',
                  child: InputTitle(text: 'Password')
              ),
              Hero(tag: 'password_field', child: TextInputField(
                hint: 'Enter your password',
                iconAssetName: 'assets/icons/lock.svg',
                validator: InputValidators.validatePassword,
                inputType: TextInputType.visiblePassword,
                onChanged: (value){
                  context.read<LoginBloc>().add(PasswordChanged(value));
                },
              )),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: BlocConsumer<LoginBloc, AuthState>(
                  listener: (context, state) {
                    if(state.isAuthenticated){
                      context.go(Screen.home);
                    }
                    else if(state.errorMessage != null){
                      ToastManager().show(context, state.errorMessage!);
                      context.read<LoginBloc>().add(ResetError());
                    }
                  },
                  builder: (context, state){
                    return Hero(tag: 'action_button', child: PrimaryButton(
                      text: 'Sign In',
                      isLoading: state.isLoading,
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          context.read<LoginBloc>().add(Login());
                        }
                      },
                    ));
                  },
                  buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                )
              ),
              Row(
                children: [
                  Expanded(child: Divider(color: context.theme.colors.foreground.withValues(alpha: 0.5),)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                        'OR CONTINUE WITH', style: context.theme.textTheme.bodySmall
                          .withColor(context.theme.colors.foreground),
                    ),
                  ),
                  Expanded(child: Divider(color: context.theme.colors.foreground.withValues(alpha: 0.5),)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 46),
                child: OutlinedButton(
                    onPressed: (){
                      context.read<LoginBloc>().add(BiometricLogin());
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: context.theme.colors.foreground),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgIcon('assets/icons/fingerprint.svg', color: context.theme.colors.foreground),
                        const SizedBox(width: 16),
                        Text(
                          'Biometric Login',
                          style: context.theme.textTheme.bodySmall
                              .withColor(context.theme.colors.foreground),
                        )
                      ],
                    )
                ),
              ),
              Hero(tag: 'bottom_text', child: BottomText(
                text: 'Don\'t have an account? ',
                actionText: 'Sign Up',
                onAction: () {
                  context.pushReplacement(Screen.signup);
                },
              ))
            ],
          ),
        )),
      )
    );
  }

}