part of 'subpost_bloc.dart';

abstract class SubpostEvent extends Equatable {
  const SubpostEvent();

  @override
  List<Object> get props => [];
}

class FetchSubPost extends SubpostEvent{

  const FetchSubPost();

  @override
  List<Object> get props => [];
}

class DoSubPostEvent extends SubpostEvent{
  final SubPostDto subpostDto;
  final String imagePath;
  
  const DoSubPostEvent(this.subpostDto, this.imagePath);
}