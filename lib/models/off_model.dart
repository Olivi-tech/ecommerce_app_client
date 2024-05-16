class OffModel {
  String? docId;
  String? season;
  String? off;
  OffModel({
    this.docId,
    this.season,
    this.off,
  });
  OffModel.fromJson({required Map<String, dynamic> jsonData}) {
    docId = jsonData['doc_id'];
    off = jsonData['off'];
    season = jsonData['season'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['doc_id'] = docId;
    data['off'] = off;
    data['season'] = season;
    return data;
  }
}
