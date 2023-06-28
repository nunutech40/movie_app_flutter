import 'package:mockito/annotations.dart';
import 'package:movie_app_flutter/data/datasources/movie_remote_data_source.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
