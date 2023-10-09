import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/userModel.dart';

String? uid;
final RegExp emailValid =
RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const Color mainColor=Colors.deepPurple;