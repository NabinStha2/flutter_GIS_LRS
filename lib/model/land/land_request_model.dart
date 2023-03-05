class LandRequestModel {
  int? page;
  int? limit;
  String? search;
  LandRequestModel({
    this.page,
    this.limit,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
      };
}
