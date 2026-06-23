import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Scope {
  id: music

  property int chosenPlayer: 0
  readonly property MprisPlayer activePlayer: Mpris.players.values[chosenPlayer] ?? undefined

  property real accurateLength//: activePlayer.length
  property real accuratePosition//: activePlayer.position
  property string currentTitle

  onActivePlayerChanged: {
    if (activePlayer) {
      activePlayer.postTrackChanged.connect(trackRefresh)
      trackRefresh()
    }
  }

  function trackRefresh() {
    if (activePlayer != null) {
      accurateLength = activePlayer.length
      accuratePosition = activePlayer.position

      if (currentTitle != activePlayer.trackTitle) getLyrics(activePlayer.trackTitle, activePlayer.trackArtist)
      currentTitle = activePlayer.trackTitle
      console.log(activePlayer.trackArtUrl)
    }
  }

  Timer {
    running: music.activePlayer ? music.activePlayer.isPlaying : false
    onTriggered: {
      //music.activePlayer.positionChanged()
      music.accuratePosition += 0.125
    }

    interval: 125
    repeat: true

  }

  property var lyricData

  function getLyrics(title: string, artist: string) {
    var req = new XMLHttpRequest();
    var url = "https://lrclib.net/api/get?artist_name="
      + encodeURIComponent(artist)
      + "&track_name="
      + encodeURIComponent(title)

    console.log(url)
    req.open("GET", url)

    music.lyricData = {
      trackName: ""
    }

    req.onreadystatechange = function() {
      if (req.readyState == 4) {
        music.lyricData = JSON.parse(req.responseText);

        console.log("Lyric data reloaded!");
        //console.log(req.responseText);
      }
    }

    req.send()
    console.log("Reloading lyric data...");
  }

  property var colors: activePlayer.trackArtUrl ? colorMaker.colors.map((col) => {
    //return col
    var tint = Qt.color(theme.surface)
    var red = (col.r * 0.7) + (tint.r * 0.3)
    var green = (col.g * 0.7) + (tint.g * 0.3)
    var blue = (col.b * 0.7) + (tint.b * 0.3)
    return Qt.rgba(red, green, blue, col.a)
      }) : Array(8).fill(theme.secondary)

  property color accent: (theme.mode == "dark" ? colorMaker.colors[6] : colorMaker.colors[1]) ?? theme.primary

  ColorQuantizer {
    id: colorMaker
    source: music.activePlayer ? music.activePlayer.trackArtUrl : ""
    depth: 3
    rescaleSize: 64
  }
}
