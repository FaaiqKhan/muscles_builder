import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/loaders.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/profile/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  Widget _editableProfileDataWidget(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          width: Spacings.contentSpacingOf8,
        ),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  final int loaderValue = Random().nextInt(Loaders.loadingViews.length);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
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
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 80,
                      child: const Icon(
                        Icons.person,
                        size: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Spacings.contentSpacingOf32,
                  ),
                  _editableProfileDataWidget(
                    context,
                    label: "Name: ",
                    value: "John Doe",
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
