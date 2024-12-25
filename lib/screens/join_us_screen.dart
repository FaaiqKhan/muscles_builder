import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/join_us/join_us_cubit.dart';
import 'package:muscles_builder/validator.dart';

class JoinUs extends StatelessWidget with Validator {
  JoinUs({super.key});

  final JoinUsCubit _joinUsCubit = JoinUsCubit();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Join Us",
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
          child: BlocSelector<JoinUsCubit, JoinUsState, AutovalidateMode>(
            bloc: _joinUsCubit,
            selector: (state) => state.autoValidateMode,
            builder: (context, AutovalidateMode autoValidateMode) {
              return Form(
                key: _formKey,
                autovalidateMode: autoValidateMode,
                child: Column(
                  children: [
                    TextFormField(
                      validator: validateName,
                      onChanged: _joinUsCubit.updateName,
                      keyboardType: TextInputType.name,
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(
                          Icons.person,
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
                    TextFormField(
                      validator: validateEmail,
                      onChanged: _joinUsCubit.updateEmail,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                    BlocSelector<JoinUsCubit, JoinUsState, bool>(
                      bloc: _joinUsCubit,
                      selector: (state) => state.obscureText,
                      builder: (context, obscureText) {
                        return Column(
                          children: [
                            TextFormField(
                              validator: validatePassword,
                              onChanged: _joinUsCubit.updatePassword,
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
                                labelText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryFixed,
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
                            ),
                            const SizedBox(height: Spacings.contentSpacingOf16),
                            TextFormField(
                              validator: (value) => validateConfirmPassword(
                                value,
                                _joinUsCubit.state.password,
                              ),
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
                              onChanged: _joinUsCubit.updateConfirmPassword,
                              decoration: InputDecoration(
                                labelText: 'Confirm password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryFixed,
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
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: Spacings.contentSpacingOf16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Become a Member",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
