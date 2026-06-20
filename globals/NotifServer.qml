import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
  id: notifRoot

  property list<NotificationInfo> shownNotifs: []
  property list<NotificationInfo> storedNotifs: []

  NotificationServer {
    id: server

    keepOnReload: false
    bodyHyperlinksSupported: true
    bodyImagesSupported: true
    bodyMarkupSupported: true

    onNotification: notification => {
      notification.tracked = true;

      notifRoot.shownNotifs.push(notifComponent.createObject(notifRoot, {
        notification: notification,
        timeLeft: notification.expireTimeout == -1 ? 10 : notification.expireTimeout,
        totalTime: notification.expireTimeout == -1 ? 10 : notification.expireTimeout,
      }));
    }
  }

  function remove(id, stored) {
    const i = !stored ? shownNotifs.findIndex(n => n.notification.id == id)
      : storedNotifs.findIndex(n => n.notification.id == id);

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
    property bool pinned: false
  }

  Component {
    id: notifComponent

    NotificationInfo {}
  }
}
