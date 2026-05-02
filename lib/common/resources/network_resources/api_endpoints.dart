abstract class APIEndpoints {
  static String homeDataByIdEndPoint(id) => "/api/sample/$id";

  static String homeDataEndPoint = "/api/sample/home";

  static String loginEndPoint = "/auth/login";
  static String signupEndPoint = "/auth/signup";

  static String onboardingEndPoint = "/me/onboarding";

  static String dashboardEndPoint = "/me/risk";

  static String newChat = '/chat/new';

  static String sendChat(String id) => '/v1/chats/${id}/messages';
}
