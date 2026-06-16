import Quickshell
import Quickshell.Io
import QtQuick

Scope {

  FileView {
    id: data
    path: Qt.resolvedUrl("../../tasks.json")
    watchChanges: true
    onFileChanged: reload()
    blockLoading: true

    onAdapterUpdated: {
      console.log("task changed!");
      writeAdapter()
    }

    JsonAdapter {
      id: a
      //property list<JsonObject> tasks: []
    }
  }
}
