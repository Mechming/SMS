import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';

class CameraCubit extends Cubit<CameraState> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  CameraCubit(CameraDescription camera) : super(CameraInitial()) {
    _initializeController(camera);
  }

  _initializeController(CameraDescription camera) async {
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;
    emit(CameraReady(_controller));
  }

  Future<void> takePicture() async {
    if (state is CameraReady) {
      final image = await (state as CameraReady).controller.takePicture();
      emit(PictureTaken(image));
    }
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}

abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {
  final CameraController controller;

  CameraReady(this.controller);
}

class PictureTaken extends CameraState {
  final XFile picture;

  PictureTaken(this.picture);
}
