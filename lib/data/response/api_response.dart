
import '../status.dart';

class ApiResponse<T> {
  STATUS? status;
  T? data;
  String? error;
  ApiResponse();
  ApiResponse.loading() : status = STATUS.LOADING;
  ApiResponse.success(this.data) : status = STATUS.SUCCESS;
  ApiResponse.error(this.error) : status = STATUS.ERROR;
}
