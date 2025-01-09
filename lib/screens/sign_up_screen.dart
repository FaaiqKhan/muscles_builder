import 'dart:math';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/commons.dart';
import 'package:muscles_builder/constants/loaders.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/sign_up/sign_up_cubit.dart';
import 'package:muscles_builder/screens/sign_in_screen.dart';
import 'package:muscles_builder/validator.dart';

class SignUpScreen extends StatelessWidget with Validator {
  SignUpScreen({super.key});

  final SignUpCubit _signUpCubit = SignUpCubit(
    UserAuthenticationUseCaseImpl(
      UserAuthenticationRepositoryImpl(),
    ),
  );

  final _formKey = GlobalKey<FormState>();
  final int loaderValue = Random().nextInt(Loaders.loadingViews.length);

  void _signUpAction() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _signUpCubit.signUp();
      return;
    }
    _signUpCubit.updateAutoValidateMode(
      AutovalidateMode.always,
    );
  }

  void _navigateToSignInScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }

  void _navigateToPreviousScreen(BuildContext context) =>
      Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      bloc: _signUpCubit,
      listener: (context, state) {
        if (state.errorMessage != null) {
          Commons.showDefaultSnackBar(context, state.errorMessage!);
        } else if (state.isSuccess) {
          _navigateToPreviousScreen(context);
        }
      },
      child: Stack(
        children: [
          GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: Text(
                  "SignUp",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                  child:
                      BlocSelector<SignUpCubit, SignUpState, AutovalidateMode>(
                    bloc: _signUpCubit,
                    selector: (state) => state.autoValidateMode,
                    builder: (context, AutovalidateMode autoValidateMode) {
                      return Form(
                        key: _formKey,
                        autovalidateMode: autoValidateMode,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "When you have a clear vision of your goal, it's easier to take the first step towards it.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              ),
                              const SizedBox(
                                height: Spacings.contentSpacingOf24,
                              ),
                              TextFormField(
                                validator: validateEmail,
                                onChanged: _signUpCubit.updateEmail,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryFixed,
                                  ),
                                  border: const OutlineInputBorder(),
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryFixed,
                                      ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      width: 1.0,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: Spacings.contentSpacingOf16,
                              ),
                              BlocSelector<SignUpCubit, SignUpState, bool>(
                                bloc: _signUpCubit,
                                selector: (state) => state.obscureText,
                                builder: (context, obscureText) {
                                  return Column(
                                    children: [
                                      TextFormField(
                                        validator: validatePassword,
                                        onChanged: _signUpCubit.updatePassword,
                                        obscureText: obscureText,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        cursorColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
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
                                            onPressed:
                                                _signUpCubit.toggleObscureText,
                                            icon: Icon(
                                              _signUpCubit.state.obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryFixed,
                                            ),
                                          ),
                                          border: const OutlineInputBorder(),
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryFixed,
                                              ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: Spacings.contentSpacingOf16,
                                      ),
                                      TextFormField(
                                        validator: (value) =>
                                            validateConfirmPassword(
                                          value,
                                          _signUpCubit.state.password,
                                        ),
                                        obscureText: obscureText,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        cursorColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            ),
                                        onChanged:
                                            _signUpCubit.updateConfirmPassword,
                                        decoration: InputDecoration(
                                          labelText: "Confirm password",
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryFixed,
                                          ),
                                          border: const OutlineInputBorder(),
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryFixed,
                                              ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: Spacings.contentSpacingOf32,
                              ),
                              ElevatedButton(
                                onPressed: _signUpAction,
                                child: Text(
                                  "SignUp",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: Spacings.contentSpacingOf12,
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryFixed,
                                        ),
                                  ),
                                  TextButton(
                                    onPressed: () => _navigateToSignInScreen(
                                      context,
                                    ),
                                    child: Text(
                                      "SignIn",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                            fontSize: 12,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<SignUpCubit, SignUpState>(
            bloc: _signUpCubit,
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, bloc) => Visibility(
              visible: _signUpCubit.state.isLoading,
              child: Loaders.loaderContainer(
                context,
                loaderValue: loaderValue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
