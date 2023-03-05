String? getQuery(
  dynamic reqData, {
  String? sort,
  String? search,
}) {
  String fullquery = '?';
  if (reqData?.limit != null) {
    fullquery += "limit=${reqData?.limit}";
  } else {
    fullquery += "limit=3";
  }
  if (reqData?.page != null) {
    fullquery += "&page=${reqData?.page}";
  } else {
    fullquery += "&page=1";
  }
  if (sort != null) {
    fullquery += "&sort=$sort";
  }
  if (search != null) {
    fullquery += "&search=$search";
  }

  return fullquery == '?' ? '' : fullquery;
}
