import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/post/post_response.dart';
import '../../../models/post/post_dto.dart';
import '../../../repository/postRepository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<postEvent, PostState> {

  final PostApiRepository public;

  PostBloc(this.public) : super(BlocPostInitial()) {
    on<FetchPost>(_PostFetched);
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
}