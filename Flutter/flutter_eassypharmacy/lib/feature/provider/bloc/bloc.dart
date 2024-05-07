export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:equatable/equatable.dart';
export 'package:flutter_eassypharmacy/feature/provider/bloc/bloc.dart';

export 'authentication/authentication_cubit.dart';
export 'home/get_list_medicines_cubit.dart';
export 'register_login/register_cubit.dart';
export 'register_login/login_cubit.dart';

import 'package:logger/logger.dart';

var logger = Logger(
  filter: null, // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(methodCount: 0),
  output: null, // Use the default LogOutput (-> send everything to console)
);
