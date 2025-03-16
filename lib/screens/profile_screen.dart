import 'dart:math';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muscles_builder/constants/loaders.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/profile/profile_cubit.dart';
import 'package:muscles_builder/validator.dart';
import 'package:muscles_builder/widgets/animated_edit_buttons.dart';

class ProfileScreen extends StatelessWidget with Validator {
  ProfileScreen({super.key});

  final int loaderValue = Random().nextInt(Loaders.loadingViews.length);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ProfileCubit _profileCubit = ProfileCubit(
    GetIt.I.get<UserProfileUsecase>(),
    GetIt.I.get<UserAuthenticationUseCase>(),
  )..loadProfile();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  void showModelBottomSheetForImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            children: [
              const SizedBox(
                height: Spacings.contentSpacingOf24,
              ),
              ListTile(
                title: const Text("Camera"),
                leading: const Icon(Icons.camera_alt),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Gallery"),
                leading: const Icon(Icons.browse_gallery),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add bloc listener to show snack bar on error
    return Stack(
      children: [
        Scaffold(
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
                callback: (isOpen) {
                  debugPrint(isOpen.toString());
                  if (isOpen) {
                    _profileCubit.toggleEditing();
                  } else {
                    _profileCubit.toggleEditing();
                  }
                },
                children: [
                  IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _profileCubit.updateProfile(
                          name: _nameController.text,
                          email: _emailController.text,
                          phoneNumber: "",
                        );
                      }
                    },
                    icon: const Icon(Icons.save),
                  ),
                ],
              )
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Spacings.contentSpacingOf32,
                  ),
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    bloc: _profileCubit,
                    buildWhen: (prevState, currentState) =>
                        prevState.isEditing != currentState.isEditing,
                    builder: (context, state) {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _profileCubit.state.isEditing
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.secondary,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixed,
                                size: MediaQuery.of(context).size.width * 0.15,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _profileCubit.state.isEditing,
                            replacement: const SizedBox.shrink(),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixed,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                onPressed: () => showModelBottomSheetForImage(
                                  context,
                                ),
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacings.contentSpacingOf16,
                  ),
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      bloc: _profileCubit,
                      builder: (context, state) {
                        if (state is ProfileLoaded) {
                          _nameController.text = state.userEntity.name;
                          _emailController.text = state.userEntity.email;
                        }
                        return Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              enabled: false,
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
                                disabledBorder: const OutlineInputBorder(),
                              ),
                              validator: validateEmail,
                            ),
                            const SizedBox(
                              height: Spacings.contentSpacingOf16,
                            ),
                            TextFormField(
                              controller: _nameController,
                              enabled: _profileCubit.state.isEditing,
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
                                disabledBorder: const OutlineInputBorder(),
                              ),
                              validator: validateName,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<ProfileCubit, ProfileState>(
          bloc: _profileCubit,
          builder: (context, state) => Visibility(
            visible: state is ProfileLoading,
            child: Loaders.loaderContainer(
              context,
              loaderValue: loaderValue,
            ),
          ),
        ),
      ],
    );
  }
}
