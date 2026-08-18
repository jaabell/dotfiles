import QtQuick
import qs.Ui

BarWidget {
  id: root
  moduleName: "jaabell.tensorcruncher"

  implicitWidth: hostname.implicitWidth + 16
  implicitHeight: barSize

  Text {
    id: hostname
    anchors.centerIn: parent
    text: "tensorcruncher"
    color: "#89b4fa"
    font.family: root.fontFamily
    font.pixelSize: Style.font.caption
    font.bold: true
  }
}
