import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
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
      floatingActionButton: BlocBuilder<CameraCubit, CameraState>(
        builder: (context, state) {
          if (state is PictureTaken) {
            return FloatingActionButton(
              onPressed: () async {
                List<int> imageBytes = state.imageBytes;
                try {
                  var response = await http.post(
                    Uri.parse('Keine Url was da los'),
                    body: {
                      'image': base64Encode(imageBytes),
                    },
                  );

                  if (response.statusCode == 200) {
                    print('Image sent successfully!');
                  } else {
                    print(
                        'Failed to send image. Status code: ${response.statusCode}');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Icon(Icons.send),
            );
          } else {
            return FloatingActionButton(
              onPressed: () {
                context.read<CameraCubit>().takePicture();
              },
              child: const Icon(Icons.camera_alt),
            );
          }
        },
      ),
    );
  }
}
