const String base = "http://10.0.2.2:8000/api/v2/";
const String registerUrl = base + 'users';
const String loginUrl = base + 'login';
const String logoutUrl = base + 'logout';
const String friendsUrl = base + 'users/me/friends';
const String usersUrl = base + 'users_all';
const String partiesUrl = base + 'parties';
const String billingsUrl = base + 'billings';
const String contribUrl = base + 'contributions';
String billingsDetailUrl(int id) {
  return billingsUrl + '/' + id.toString();
}
String contribsDetailUrl(int id) {
  return contribUrl + '/' + id.toString();
}
