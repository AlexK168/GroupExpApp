import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view_model/login_view_model.dart';
import '../view_model/register_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
];