import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pam
import QtQuick

Scope {
  id: lockRoot

  signal unlocked()
  signal failed()
  signal lock()

  property string currentText: ""
  property bool unlockInProgress: false
  property bool showFaliure: false

  onCurrentTextChanged: showFaliure = false;

  function tryUnlock() {
    if (currentText === "") return;

    lockRoot.unlockInProgress = true;
    pam.start();
  }

  PamContext {
    id: pam

    configDirectory: "pam"
    config: "password.conf"

    onPamMessage: {
      if (this.responseRequired) {
        this.respond(lockRoot.currentText);
      }
    }

    onCompleted: result => {
      if (result == PamResult.Success) {
        lockRoot.currentText = "";
        lockRoot.showFaliure = true;
      }

      lockRoot.unlockInProgress = false;
    }
  }

  onUnlocked: {
    lock.locked = false;
  }

  onLock: {
    lock.locked = true;
  }

  WlSessionLock {
    id: lock
    locked: false
    WlSessionLockSurface {
      Lockscreen {}
    }
  }
}
