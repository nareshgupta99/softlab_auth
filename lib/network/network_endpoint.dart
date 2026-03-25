enum Endpoints { login, register, forgotPassword, verifyOtp, resetPassword }

const Map<Endpoints, String> endpointRawValues = {
  // AUTHENTICATION
  Endpoints.login: "/user/login",
  Endpoints.register: "/user/register",
  Endpoints.forgotPassword: "/user/forgot-password",
  Endpoints.verifyOtp: "/user/verify-otp",
  Endpoints.resetPassword: "/user/reset-password",
};
