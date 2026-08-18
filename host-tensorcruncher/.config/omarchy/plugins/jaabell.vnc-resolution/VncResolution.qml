import QtQuick
import Quickshell.Io
import qs.Ui

BarWidget {
  id: root
  moduleName: "jaabell.vnc-resolution"

  property string resolution: ""
  property bool nativeResolution: true

  function refresh() {
    if (!query.running) query.running = true
  }

  function toggle() {
    if (!toggleProcess.running) toggleProcess.running = true
  }

  Component.onCompleted: refresh()

  Process {
    id: query
    command: ["hyprctl", "-j", "monitors"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        let monitors
        try {
          monitors = JSON.parse(text || "[]")
        } catch (error) {
          return
        }

        const monitor = monitors.find(item => item.name === "HDMI-A-1")
        if (!monitor) return

        root.resolution = monitor.width + "x" + monitor.height
        root.nativeResolution = monitor.width === 3840 && monitor.height === 2160
      }
    }
  }

  Process {
    id: toggleProcess
    command: ["bash", "-lc", "exec \"$HOME/.local/bin/vnc-res-toggle\""]
    onExited: root.refresh()
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: root.refresh()
  }

  visible: resolution !== ""
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.resolution
    foreground: "#a6e3a1"
    activeColor: "#f9e2af"
    active: !root.nativeResolution
    fontSize: Style.font.caption
    horizontalMargin: 6
    tooltipText: "Toggle VNC resolution"
    onPressed: root.toggle()
  }
}
