import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_tracker/core/service/toast_manager.dart';
import 'package:sub_tracker/core/util/input_validator.dart';

import '../../../../router/routes.dart';
import '../../../shared/widgets/primary_button.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../bloc/signup_bloc.dart';
import '../widgets/bottom_text.dart';
import '../widgets/header_box.dart';
import '../widgets/input_title.dart';
import '../widgets/scrollable_container.dart';
import '../widgets/text_field.dart';

class SignupScreen extends StatelessWidget{
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignupBloc(context.read()),
        child: const SignupView()
    );
  }

}

class SignupView extends StatefulWidget{
  const SignupView({super.key});

  @override
  State<StatefulWidget> createState() => SignupViewState();

}

class SignupViewState extends State<SignupView>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ScrollableContainer(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Hero(tag: 'header', child: HeaderBox()),
                    const InputTitle(text: 'Name'),
                    TextInputField(
                      hint: 'Enter your name',
                      iconAssetName: 'assets/icons/user.svg',
                      validator: InputValidators.validateName,
                      inputType: TextInputType.emailAddress,
                      onChanged: (value){
                        context.read<SignupBloc>().add(NameChanged(value));
                      },
                    ),
                    const Hero(
                        tag: 'email_title',
                        child: InputTitle(text: 'Email')
                    ),
                    Hero(tag: 'email_field', child: TextInputField(
                      hint: 'Enter your email',
                      iconAssetName: 'assets/icons/mail.svg',
                      validator: InputValidators.validateEmail,
                      inputType: TextInputType.emailAddress,
                      onChanged: (value){
                        context.read<SignupBloc>().add(EmailChanged(value));
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
                        context.read<SignupBloc>().add(PasswordChanged(value));
                      },
                    )),
                    const InputTitle(text: 'Confirm Password'),
                    TextInputField(
                      hint: 'Confirm your password',
                      iconAssetName: 'assets/icons/lock.svg',
                      validator: (value) {
                        return InputValidators.validateConfirmPassword(
                            value, context.read<SignupBloc>().state.authInfo.password
                        );
                      },
                      inputType: TextInputType.visiblePassword,
                      onChanged: (_){},
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 32),
                        child: BlocConsumer<SignupBloc, AuthState>(
                          listener: (context, state) {
                            if(state.isAuthenticated){
                              context.go(Screen.dashboard);
                            }
                            else if(state.errorMessage != null){
                              ToastManager().show(context, state.errorMessage!);
                              context.read<SignupBloc>().add(ResetError());
                            }
                          },
                          builder: (context, state){
                            return Hero(tag: 'action_button', child: PrimaryButton(
                              text: 'Sign Up',
                              isLoading: state.isLoading,
                              onPressed: () {
                                if (_formKey.currentState?.validate() == true) {
                                  context.read<SignupBloc>().add(Signup());
                                }
                              },
                            ));
                          },
                          buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                        )
                    ),
                    Hero(tag: 'bottom_text', child: BottomText(
                      text: 'Already have an account? ',
                      actionText: 'Sign In',
                      onAction: () {
                        context.pushReplacement(Screen.login);
                      },
                    ))
                  ],
                )
            )
        ),
      ),
    );
  }

}