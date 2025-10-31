import 'dart:core';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/enitites/api_character_response.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/enitites/character_entity.dart';

part "rick_and_morty_api.g.dart";

@RestApi(baseUrl: "https://rickandmortyapi.com/api")
abstract class RickAndMortyApi {
  factory RickAndMortyApi(Dio dio, {String baseUrl}) = _RickAndMortyApi;

  @GET("/character")
  Future<ApiCharacterResponse> getList({@Query("page") int page = 1});

  @GET('/character/{id}')
  Future<CharacterEntity> getCharacter({@Path("id") required int id});
}
