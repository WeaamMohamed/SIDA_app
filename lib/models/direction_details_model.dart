class DirectionDetails{
  String encodedPoints;
  String distanceText;
  String durationText;
  int distanceValue;
  int durationValue;

  DirectionDetails(
      {
        this.encodedPoints,
        this.distanceText,
      this.durationText,
      this.distanceValue,
      this.durationValue,});


  DirectionDetails.fromMap(Map<String, dynamic> jsonMap){

    encodedPoints = jsonMap["routes"][0]["overview_polyline"]["points"];
    distanceText = jsonMap["routes"][0]["legs"][0]["distance"]["text"];
    distanceValue =jsonMap["routes"][0]["legs"][0]["distance"]["value"];
    durationText =jsonMap["routes"][0]["legs"][0]["duration"]["text"];
    durationValue = jsonMap["routes"][0]["legs"][0]["duration"]["value"];

  }

}