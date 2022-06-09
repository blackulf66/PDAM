import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/post/post_response.dart';
import '../../../repository/postRepository/post_repository.dart';

part 'postsubpostid_event.dart';
part 'postsubpostid_state.dart';


class PostSubPostIdBloc extends Bloc<PostsubpostidEvent, postsubpostidState> {

  final PostApiRepository public;

  PostSubPostIdBloc(this.public) : super(BlocpostsubpostidInitial()) {
    on<FetchPostSubPostId2>(_PostsubpostidFetched);
}
void _PostsubpostidFetched(FetchPostSubPostId2 event, Emitter<postsubpostidState> emit) async {
    try {
      final post = await public.fetchPostsBySubpostId(event.postId);

      emit(postsubpostidFetched(post));
      return;
    } on Exception catch (e) {
      emit(postsubpostidFetchError(e.toString()));
    }
  }

}