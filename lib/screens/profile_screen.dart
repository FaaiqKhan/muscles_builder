import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/loaders.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/profile/profile_cubit.dart';
import 'package:muscles_builder/validator.dart';
import 'package:muscles_builder/widgets/animated_edit_buttons.dart';

class ProfileScreen extends StatelessWidget with Validator {
  ProfileScreen({super.key});

  final int loaderValue = Random().nextInt(Loaders.loadingViews.length);

  final GlobalKey _formKey = GlobalKey<FormState>();
  final ProfileCubit _profileCubit = ProfileCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _profileCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Profile",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          actions: [
            ExpandableFab(
              distance: 50,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.save),
                ),
              ],
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.width * 0.35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          radius: 100,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.15,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacings.contentSpacingOf16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: Spacings.contentSpacingOf32,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
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
                                labelText: "Name",
                                prefixIcon: Icon(
                                  Icons.abc,
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
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                              ),
                              validator: validateName,
                            ),
                            const SizedBox(
                              height: Spacings.contentSpacingOf16,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
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
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                              ),
                              validator: validateEmail,
                            ),
                            const SizedBox(
                              height: Spacings.contentSpacingOf16,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
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
                                labelText: "Phone Number",
                                prefixIcon: Icon(
                                  Icons.phone,
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
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                              ),
                              validator: validatePhoneNumber,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) => Visibility(
                  visible: state is ProfileLoading,
                  child: Loaders.loaderContainer(
                    context,
                    loaderValue: loaderValue,
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
