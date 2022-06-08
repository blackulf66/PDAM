part of 'postsubpostid_bloc.dart';

abstract class PostsubpostidEvent extends Equatable {
  const PostsubpostidEvent();

  @override
  List<Object> get props => [];
}

class FetchPostSubPostId extends PostsubpostidEvent{

  const FetchPostSubPostId();

  

  @override
  List<Object> get props => [];
}

class FetchPostSubPostId2 extends FetchPostSubPostId{
  final int postId;
  
  const FetchPostSubPostId2(this.postId);
}