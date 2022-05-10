import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/subpost/Subpost_response.dart';
import '../../../models/subpost/subpost_dto.dart';
import '../../../repository/subpostRepository/subpost_repository.dart';

part 'subpost_event.dart';
part 'subpost_state.dart';

class SubPostBloc extends Bloc<SubpostEvent, SubPostState> {

  final SubPostApiRepository public;

  SubPostBloc(this.public) : super(BlocSubPostInitial()) {
    on<FetchSubPost>(_PostFetched);
}
void _PostFetched(FetchSubPost event, Emitter<SubPostState> emit) async {
    try {
      final post = await public.fetchSubPosts();

      emit(SubPostFetched(post));
      return;
    } on Exception catch (e) {
      emit(SubPostFetchError(e.toString()));
    }
  }
}