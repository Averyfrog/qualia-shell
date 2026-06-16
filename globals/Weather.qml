import Quickshell
import Quickshell.Io
import QtQuick

Scope {
  id: weather

  property var data

  // THESE CODES TOOK SO LONG TO WRITE :sob:
  property var wmo: JSON.parse(wmoFile.text())

  FileView {
    id: wmoFile
    path: Qt.resolvedUrl("./WMO_codes.json")
    watchChanges: true
    onFileChanged: reload()
    blockLoading: true
  }

  Component.onCompleted: {
    getWeather()
  }

  property int min: time.minutes

  onMinChanged: {
    // Update weather every 15 mins c:
    if (min % 15 == 0) {
      getWeather()
    }
  }

  property string latitude: settings.weather.location.coordinates.latitude
  onLatitudeChanged: getWeather()
  property string longitude: settings.weather.location.coordinates.longitude
  onLongitudeChanged: getWeather()

  // Function pls dont break again 🙏🙏
  function getWeather() {
    var req = new XMLHttpRequest();
    console.log(latitude)
    var url = "https://api.open-meteo.com/v1/forecast?" +
    "latitude=" + latitude +
    "&longitude=" + longitude +
    // my god this is a lot of data
    "&daily=sunset,sunrise,uv_index_max,wind_speed_10m_max,rain_sum,showers_sum,snowfall_sum,precipitation_probability_max,temperature_2m_max,temperature_2m_min"
    + "&hourly=rain,showers,snowfall,weather_code,temperature_2m,precipitation_probability"
    + "&current=weather_code,is_day,temperature_2m,apparent_temperature,rain,showers,snowfall&timezone=auto&forecast_days=3"

    console.log(url)

    req.open("GET", url);

    req.onreadystatechange = function() {
      if (req.readyState == 4) {
        data = JSON.parse(req.responseText);
        console.log("Weather data reloaded!");
        //console.log(req.responseText);
      }
    }

    if (latitude != "" && longitude != "") {
      req.send()
      console.log("Reloading weather data...");
      console.log(url)
    }
  }

  // update this later pls to use sunrise/sunset cuz im sick of seeing the moon icon when its bright <3
  function getWmoInfo(hour: int, code: string): var {
    var wmoData = weather.wmo[code]
    if (hour >= 5 && hour < 22) {
      return wmoData["day"]
    }
    return wmoData["night"]
  }

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

}
