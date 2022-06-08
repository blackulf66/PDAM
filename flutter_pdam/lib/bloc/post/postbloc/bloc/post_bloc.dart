import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/post/post_dto.dart';
import '../../../../models/post/post_response.dart';
import '../../../../repository/postRepository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<postEvent, PostState> {

  final PostApiRepository public;

  PostBloc(this.public) : super(BlocPostInitial()) {
    on<FetchPost>(_PostFetched);
    on<DoPostEvent>(_doPostEvent);
}
void _PostFetched(FetchPost event, Emitter<PostState> emit) async {
    try {
      final post = await public.fetchPosts();

      emit(PostFetched(post));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }

  void _doPostEvent(DoPostEvent event, Emitter<PostState> emit) async {
    try {
      final postResponse = await public.createPost(event.postDto, event.imagePath);
      emit(PostSuccessState(postResponse));
      return;
    } on Exception catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }
}