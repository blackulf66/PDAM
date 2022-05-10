part of 'postbloc_bloc.dart';

abstract class PostblocState extends Equatable {
  const PostblocState();
  
  @override
  List<Object> get props => [];
}

class PostblocInitial extends PostblocState {}
