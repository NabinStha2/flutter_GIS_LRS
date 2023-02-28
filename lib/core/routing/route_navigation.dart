import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

back(BuildContext context, [dynamic result]) {
  GoRouter.of(context).pop(result);
}

navigate(BuildContext context, dynamic routeName, {List<Object?>? extra}) {
  GoRouter.of(context).push(routeName, extra: extra);
}

navigateNamed(BuildContext context, String routeName,
    {params = const <String, String>{},
    queryParams = const <String, String>{},
    dynamic extra}) {

  GoRouter.of(context).pushNamed(routeName,
      params: params, queryParams: queryParams, extra: extra);
}

navigateOffAllNamed(BuildContext context, String routeName,
    {params = const <String, String>{},
    queryParams = const <String, String>{},
    dynamic extra}) {
  GoRouter.of(context).goNamed(routeName,
      params: params, queryParams: queryParams, extra: extra);
}

replaceAndPush(BuildContext context, dynamic routeName, {dynamic extra}) {
  GoRouter.of(context).pushReplacement(routeName, extra: extra);
}
