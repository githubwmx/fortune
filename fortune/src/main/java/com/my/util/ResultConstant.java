package com.my.util;

public class ResultConstant {

	public static Result Success = new Result(1, "Success");
	public static Result Error = new Result(0, "Error");

	public static Result createSuccessMessage(String message) {
		return new Result(1, message);
	}

	public static Result createSuccessMessage(String message, Object data) {
		return new Result(1, message, data);
	}

	public static Result createSuccessMessage(Object data) {
		return new Result(1, "数据查询成功", data);
	}

	public static Result createErrorMessage(String message) {
		return new Result(0, message);
	}

	public static Result getSuccess() {
		return Success;
	}

	public static void setSuccess(Result success) {
		Success = success;
	}

	public static Result getError() {
		return Error;
	}

	public static void setError(Result error) {
		Error = error;
	}

}
