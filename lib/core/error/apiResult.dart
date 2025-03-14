sealed class ApiResult<T> {}

class ApiResultSuccess<T> extends ApiResult<T> {
  T data;
  ApiResultSuccess(this.data);
}

class ApiresultError<T> extends ApiResult<T> {
  String message;
  ApiresultError(this.message);
}
