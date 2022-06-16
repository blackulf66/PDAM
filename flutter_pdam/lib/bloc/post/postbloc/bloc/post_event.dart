part of 'post_bloc.dart';

abstract class postEvent extends Equatable {
  const postEvent();

  @override
  List<Object> get props => [];
}

class FetchPost extends postEvent{

  const FetchPost();

  @override
  List<Object> get props => [];
}

class DoPostEvent extends postEvent{
  final PostDto postDto;
  final String imagePath;
  
  const DoPostEvent(this.postDto, this.imagePath);
}