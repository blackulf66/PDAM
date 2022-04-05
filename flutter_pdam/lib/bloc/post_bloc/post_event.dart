part of 'post_bloc.dart';

abstract class BlocPostEvent extends Equatable {
  const BlocPostEvent();

  @override
  List<Object> get props => [];
}

class FetchPostWithType extends  BlocPostEvent{
  final String type;
  

  const FetchPostWithType(this.type);

  @override
  List<Object> get props => [type];
}

class DoPostEvent extends  BlocPostEvent{
  final PostDto postDto;
  final String imagePath;
  
  const DoPostEvent(this.postDto, this.imagePath);
}