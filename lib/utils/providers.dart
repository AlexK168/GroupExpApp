import 'package:groupexp/view_model/create_party_view_model.dart';
import 'package:groupexp/view_model/friends_view_model.dart';
import 'package:groupexp/view_model/party_detail_view_model.dart';
import 'package:groupexp/view_model/user_search_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view_model/login_view_model.dart';
import '../view_model/parties_view_model.dart';
import '../view_model/register_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => FriendsViewModel()),
  ChangeNotifierProvider(create: (_) => UsersSearchViewModel()),
  ChangeNotifierProvider(create: (_) => PartiesViewModel()),
  ChangeNotifierProvider(create: (_) => CreatePartyViewModel()),
  ChangeNotifierProvider(create: (_) => PartyDetailViewModel()),
];