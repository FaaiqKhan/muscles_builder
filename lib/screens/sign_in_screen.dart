import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/sign_in/sign_in_cubit.dart';
import 'package:muscles_builder/screens/sign_up_screen.dart';
import 'package:muscles_builder/validator.dart';

class SignInScreen extends StatelessWidget with Validator {
  SignInScreen({super.key});

  final SignInCubit _signInCubit = SignInCubit(
    UserAuthenticationUseCaseImpl(
      UserAuthenticationRepositoryImpl(),
    ),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "SignIn",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacings.contentSpacingOf12),
            child: BlocSelector<SignInCubit, SignInState, AutovalidateMode>(
              bloc: _signInCubit,
              selector: (state) => state.autoValidateMode,
              builder: (context, AutovalidateMode autoValidateMode) {
                return Form(
                  key: _formKey,
                  autovalidateMode: autoValidateMode,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: validateEmail,
                        onChanged: _signInCubit.updateEmail,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).colorScheme.onPrimary,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).colorScheme.onPrimaryFixed,
                          ),
                          border: const OutlineInputBorder(),
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryFixed,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacings.contentSpacingOf16),
                      BlocSelector<SignInCubit, SignInState, bool>(
                        bloc: _signInCubit,
                        selector: (state) => state.obscureText,
                        builder: (context, obscureText) {
                          return TextFormField(
                            validator: validatePassword,
                            onChanged: _signInCubit.updatePassword,
                            obscureText: obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor:
                                Theme.of(context).colorScheme.onPrimary,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixed,
                              ),
                              suffixIcon: IconButton(
                                onPressed: _signInCubit.toggleObscureText,
                                icon: Icon(
                                  _signInCubit.state.obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryFixed,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixed,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  width: 1.0,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: Spacings.contentSpacingOf32),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signInCubit.signIn();
                            return;
                          }
                          _signInCubit.updateAutoValidationMode(
                            AutovalidateMode.always,
                          );
                        },
                        child: Text(
                          "SignIn",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                      const SizedBox(height: Spacings.contentSpacingOf16),
                      Text(
                        "Or",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                      ),
                      const SizedBox(height: Spacings.contentSpacingOf16),
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        ),
                        child: Text(
                          "SignUp",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
