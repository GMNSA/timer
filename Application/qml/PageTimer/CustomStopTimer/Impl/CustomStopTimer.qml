import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import CustomButton.Impl 1.0

Column {
    id: _root
    anchors.fill: parent

    property alias text: _labelNum.text

    Item {
        id: _topDelimeter
        width: 100
        height: parent.height * 0.1
    }

    Rectangle {
        id: _displayRec

        width: parent.width
        height: parent.height / 9
        color: "transparent"

        RowLayout {
            anchors.fill: _displayRec
            spacing: 10

            Rectangle {
                id: _rec

                Layout.preferredWidth: parent.width
                Layout.maximumWidth: parent.width / 1.5
                Layout.fillHeight: true
                color: "transparent"

                Label {
                    id: _labelNum

                    text: _root.text
                    anchors.centerIn: parent
                    font.pixelSize: Math.min(_root.width, _root.height) / 10
                    Layout.alignment: Qt.AlignCenter
                }
            }

            Rectangle {
                id: _deleteRec

                Layout.preferredWidth: parent.width
                Layout.maximumWidth: parent.width * 0.35
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft
                color: "transparent"

                Text {
                    id: _deleteText

                    text: "<---"
                    font.pixelSize: Math.min(_root.width, _root.height) / 9.5
                    anchors.centerIn: parent
                    color: Material.color(Material.BlueGrey)
                }

                MouseArea {
                    id: _mouseAreaDeleteRec

                    anchors.fill: _deleteRec

                    onPressed: {
                        _moduleTimer.remove();
                    }
                }
            }
        }
    }

    Item {
        height: parent.height * 0.2
        width: 100
    }

    ColumnLayout {

        anchors.horizontalCenter: parent.horizontalCenter
        RowLayout {
            CustomButton {
                text: "1"

                onPressed: {
                    _moduleTimer.display = "1"
                    _moduleTimer.changeDisplay();
                }
            }
            CustomButton {
                text: "2"

                onPressed: {
                    _moduleTimer.display = "2"
                    _moduleTimer.changeDisplay();
                }
            }
            CustomButton {
                text: "3"

                onPressed: {
                    _moduleTimer.display = "3"
                    _moduleTimer.changeDisplay();
                }
            }
        }

        RowLayout {
            CustomButton {
                text: "4"

                onPressed: {
                    _moduleTimer.display = "4"
                    _moduleTimer.changeDisplay();
                }
            }
            CustomButton {
                text: "5"

                onPressed: {
                    _moduleTimer.display = "5"
                    _moduleTimer.changeDisplay();
                }
            }
            CustomButton {
                text: "6"

                onPressed: {
                    _moduleTimer.display = "6"
                    _moduleTimer.changeDisplay();
                }
            }
        }

        RowLayout {
            CustomButton {
                text: "7"

                onPressed: {
                    _moduleTimer.display = "7"
                    _moduleTimer.changeDisplay();
                }
            }
            CustomButton {
                text: "8"

                onPressed: {
                    _moduleTimer.display = "8"
                    _moduleTimer.changeDisplay();
                }
            }
            CustomButton {
                text: "9"

                onPressed: {
                    _moduleTimer.display = "9"
                    _moduleTimer.changeDisplay();
                }
            }
        }

        CustomButton {
            id: _buttonStart
            text: ">"

            visible: _moduleTimer.isCheckedButton() ? true : true

            Layout.alignment: Qt.AlignCenter

            onPressed: {
                _moduleTimer.start()
                _stopTimer.visible = false
                _columnStartTimer.visible = true
                // _startTimer.visible = true
            }
        }
    }
}
