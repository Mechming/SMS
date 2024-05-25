import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/setting/camera_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<CameraCubit, CameraState>(
          builder: (context, state) {
            if (state is CameraInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CameraReady) {
              return CameraPreview(state.controller);
            } else if (state is PictureTaken) {
              return Image.file(File(state.picture.path));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<CameraCubit>().takePicture();
          },
          child: const Icon(Icons.camera_alt),
        ));
  }
}
