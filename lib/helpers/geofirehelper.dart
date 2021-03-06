import 'package:sida_app/models/nearby_available_drivers.dart';

class GeoFireHelper
{

  static List<NearbyAvailableDrivers> nearbyAvailableDriversList = [];

  static void removeDriverFromList(String key)

  {

    int index = nearbyAvailableDriversList.indexWhere((element) => element.key == key);

    //todo: condition??
    if(nearbyAvailableDriversList.length > 0){
      nearbyAvailableDriversList.removeAt(index);
    }
  }

  static void updateDriverNearByLocation(NearbyAvailableDrivers driver)
  {
    int index = nearbyAvailableDriversList.indexWhere((element) => element.key == driver.key);

    nearbyAvailableDriversList[index].latitude = driver.latitude;
    nearbyAvailableDriversList[index].longitude = driver.longitude;

  }

}