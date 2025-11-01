import 'package:equatable/equatable.dart';

abstract class CharacterListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCharactersPage extends CharacterListEvent {
  final int page;
  final bool isInitialLoad;

  LoadCharactersPage(this.page, {this.isInitialLoad = false});

  @override
  List<Object?> get props => [page, isInitialLoad];
}
