import 'package:flutter/material.dart';
import 'app_localization.dart';

String translate(BuildContext context, String key)
{
  return AppLocalization.of(context).translate(key);
}
