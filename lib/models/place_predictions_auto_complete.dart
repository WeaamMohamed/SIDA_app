class PlacePredictionsAutoComplete{

  String placeId;
  String mainText;
  String secondaryText;

  PlacePredictionsAutoComplete({this.secondaryText, this.mainText, this.placeId});

  PlacePredictionsAutoComplete.fromJson(Map<String, dynamic> json)
  {
    placeId = json["placeId"];
    mainText = json["structured_formatting"]["mainText"];
    secondaryText = json["structured_formatting"]["secondaryText"];
  }
}