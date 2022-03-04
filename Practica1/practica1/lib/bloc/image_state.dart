part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageReady extends ImageState {
  final String image;
  ImageReady({required this.image});
  @override
  List<Object> get props => [image];
}

class ImageError extends ImageState {
  final String error;
  ImageError({required this.error});
  @override
  List<Object> get props => [error];
}
