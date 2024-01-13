import 'package:dartz/dartz.dart';
import 'package:fic11_pos_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../models/request/auth_request_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  // Future<Either<String, AuthResponseModel>> login(
  //   String email,
  //   String password,
  // ) async {
  //   final response = await http.post(
  //     Uri.parse('${Variables.baseUrl}/api/login'),
  //     body: {
  //       'email': email,
  //       'password': password,
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return right(AuthResponseModel.fromJson(response.body));
  //   } else {
  //     return left(response.body);
  //   }
  // }
  Future<Either<String, AuthResponseModel>> login(
      AuthRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      headers: headers,
      body: requestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('server error');
    }
  }
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
      },
    );
    if (response.statusCode == 200) {
      return right(response.body);
    } else {
      return left(response.body);
    }
  }
}
