class Utils {

  static String mapStyles = ''' [
  {
      "elementType": "labels",
      "stylers": [
      {
      "visibility": "off"
      }
      ]
  },
      {
        "featureType": "administrative",
        "elementType": "geometry",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "administrative.neighborhood",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi",
        "stylers": [
          {
            "visibility": "on"
          }
        ]
      },
      {
        "featureType": "road",
        "stylers": [
          {
            "visibility": "on"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "on"
          }
        ]
      },
      {
        "featureType": "transit",
        "stylers": [
          {
            "visibility": "on"
          }
        ]
      }
      ];''';
}