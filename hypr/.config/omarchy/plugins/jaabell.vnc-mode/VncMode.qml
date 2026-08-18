import QtQuick
import Quickshell.Io
import qs.Ui

BarWidget {
  id: root
  moduleName: "jaabell.vnc-mode"

  property bool vncActive: false

  Process {
    id: checkProc
    command: ["test", "-f", "/tmp/vnc-mode"]
    onRunningChanged: {
      if (!running) root.vncActive = checkProc.exitCode === 0
    }
  }

  Timer {
    interval: 500
    running: true
    repeat: true
    onTriggered: checkProc.running = true
  }

  FileView {
    path: "/tmp/vnc-mode"
    watchChanges: true
    onFileChanged: checkProc.running = true
    onPathChanged: checkProc.running = true
  }

  visible: vncActive
  implicitWidth: vncLabel.implicitWidth + 16
  implicitHeight: barSize

  Rectangle {
    anchors.fill: parent
    color: "#ff4444"
    radius: Style.cornerRadius

    Text {
      id: vncLabel
      anchors.centerIn: parent
      text: "VNC MODE"
      color: "#ffffff"
      font.family: root.fontFamily
      font.pixelSize: Style.font.caption
      font.bold: true
    }
  }
}
