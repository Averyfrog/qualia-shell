import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Scope {
  id: notifRoot

  property list<NotificationInfo> shownNotifs: []
  property list<NotificationInfo> storedNotifs: []

  // Removes broken notifications
  onShownNotifsChanged: {
    shownNotifs = shownNotifs.filter(n => n.notification != null);
  }

  onStoredNotifsChanged: {
    storedNotifs = storedNotifs.filter(n => n.notification != null);
  }

  NotificationServer {
    id: server

    keepOnReload: false
    bodyHyperlinksSupported: true
    bodyImagesSupported: true
    bodyMarkupSupported: true

    onNotification: notification => {
      notification.tracked = true;

      var notifObjectThing = notifComponent.createObject(notifRoot, {
        notification: notification,
        timeLeft: notification.expireTimeout == -1 ? 5 : notification.expireTimeout,
        totalTime: notification.expireTimeout == -1 ? 5 : notification.expireTimeout,
        pinned: false,
        id: notification.id,
        time: new Date(),
      });

      if (!settings.notifications.dnd) notifRoot.shownNotifs.push(notifObjectThing)
      else notifRoot.storedNotifs.push(notifObjectThing)
    }
  }

  function remove(id, stored) {
    const i = !stored ? shownNotifs.findIndex(n => n.id == id)
      : storedNotifs.findIndex(n => n.id == id);

    if (i >= 0) {
      if (!stored) shownNotifs.splice(i, 1);
      else storedNotifs.splice(i, 1);
    }
  }

  function store(id) {
    const i = shownNotifs.findIndex(n => n.notification.id == id);

    if (i >= 0) {
      storedNotifs.push(shownNotifs.splice(i,1)[0]);
      print(storedNotifs.length)
    }
  }

  component NotificationInfo: QtObject {
    required property Notification notification
    required property double timeLeft
    required property double totalTime
    property bool pinned
    property int id
    property date time
  }

  Component {
    id: notifComponent

    NotificationInfo {}
  }
}
