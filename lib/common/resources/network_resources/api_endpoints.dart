abstract class APIEndpoints {
  static String homeDataByIdEndPoint(id) => "/api/sample/$id";

  static String homeDataEndPoint = "/api/sample/home";

  static String loginDataEndPointById(id) => "/api/sample/login/$id";
  static String signupEndPoint = "/auth/register";

  static String onboardingDataEndPointById(id) => "/api/sample/onboarding/$id";

  static String dashboardDataEndPointById(id) => "/api/sample/dashboard/$id";
}
