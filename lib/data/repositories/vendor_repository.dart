import 'dart:convert';
import 'package:dio/dio.dart';
import '../../core/api.dart';
import '../models/vendor/vendor_model.dart';

class VendorRepository {
  final _api = Api();

  Future<VendorModel> createAccount({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String city,
  }) async {
    try {
      Response response = await _api.sendRequest.post("/vendor/createAccount",
          data: jsonEncode({
            "email": email,
            "password": password,
            "fullName": fullName,
            "phoneNumber": phoneNumber,
            "address": address,
            "city": city,
          }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return VendorModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<VendorModel> createVendor({
    required String role,
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String city,
  }) async {
    try {
      Response response = await _api.sendRequest.post("/vendor/createVendor",
          data: jsonEncode({
            "role": role,
            "email": email,
            "password": password,
            "fullName": fullName,
            "phoneNumber": phoneNumber,
            "address": address,
            "city": city,
          }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return VendorModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<VendorModel>> fetchAllVendors() async {
    try {
      Response response = await _api.sendRequest.get("/vendor");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => VendorModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<VendorModel> signIn(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post("/vendor/signIn",
          data: jsonEncode({"email": email, "password": password}));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return VendorModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<VendorModel> updateVendor(VendorModel vendorModel) async {
    try {
      Response response = await _api.sendRequest.put(
          "/vendor/${vendorModel.id}",
          data: jsonEncode(vendorModel.toJson()));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return VendorModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<VendorModel> changePassword(VendorModel vendorModel) async {
    try {
      Response response = await _api.sendRequest.put(
          "/vendor/${vendorModel.id}/changePassword",
          data: jsonEncode(vendorModel.toJson()));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return VendorModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> removeVendor(String vendorId) async {
    try {
      // Send DELETE request to remove vendor
      Response response = await _api.sendRequest.delete("/vendor/$vendorId");

      // Check if the response is successful
      if (response.statusCode == 200) {
        // If successful, no need to return any data
        return;
      } else {
        // If not successful, handle the error
        throw "Failed to remove vendor: ${response.statusCode}";
      }
    } catch (ex) {
      // Rethrow the exception to be caught at a higher level
      rethrow;
    }
  }
}
