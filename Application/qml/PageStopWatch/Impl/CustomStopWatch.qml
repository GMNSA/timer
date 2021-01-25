import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import CustomButton.Impl 1.0

// Page {
//     id: _root
//
//     property alias fText: _text.text
//     property bool isRun: false
//
//     signal startTimer();
//     signal resetTimer();
//
//     width: 600
//     height: 400
//
//     Column{
//         // anchors.fill: parent
//         width: parent.width
//         height: parent.height / 1.5
//
//         spacing: 10
//         Rectangle {
//             id: _recRound
//             // anchors.centerIn: parent
//
//             width: parent.width / 1.5
//             height: parent.height / 5
//             // Layout.preferredWidth: parent.width / 1.5
//             // Layout.preferredHeight: parent.height / 5
//             radius: 30
//             border.width: 3
//             border.color: "black"
//             // Layout.alignment: Qt.AlignCenter
//             anchors.verticalCenter: parent.verticalCenter
//             anchors.horizontalCenter: parent.horizontalCenter
//
//             color: isRun ? "#B25151" : "#ADE8BE"
//
//             // display numbers
//             Text {
//                 id: _text
//
//                 anchors.centerIn: _recRound
//
//                 text: fText
//                 font.pixelSize: Math.min(_root.width, _root.height) / 8.5
//             }
//
//             MouseArea {
//                 anchors.fill: _recRound
//
//                 onPressed: {
//                     isRun = isRun ? false : true
//                     _root.startTimer();
//
//                     if (isRun)
//                         _buttonReset.visible = false
//                     else
//                         _buttonReset.visible = true
//                 }
//             }
//         }
//     }
//
//     CustomButton {
//         id: _buttonReset
//
//         text: "reset"
//         visible: true
//         // Layout.alignment: Qt.AlignCenter
//         anchors.top: _recRound.bottom
//         anchors.horizontalCenter: parent.horizontalCenter
//
//         onPressed: {
//             _root.resetTimer();
//         }
//     }
//
//     CustomButton {
//
//         text: "reset"
//         visible: true
//         // Layout.alignment: Qt.AlignCenter
//         anchors.top: _recRound.bottom
//         anchors.horizontalCenter: parent.horizontalCenter
//
//         onPressed: {
//             _root.resetTimer();
//         }
//     }
// }


Page {
    id: _root
    // anchors.fill: parent

    width: 600
    height: 400

    property alias fText: _text.text
    property bool isRun: false

    signal startTimer();
    signal resetTimer();

    Column {

        Rectangle {
            width: _root.width
            height: _root.height / 1.5

            color: "transparent"

            Rectangle {
                id: _recRound

                width: parent.width / 1.2
                height: parent.height / 2
                radius: 30
                border.width: 3
                border.color: "black"
                anchors.centerIn: parent
                // Layout.alignment: Qt.AlignCenter
                // anchors.verticalCenter: parent.verticalCenter
                // anchors.horizontalCenter: parent.horizontalCenter

                color: isRun ? "#B25151" : "#ADE8BE"

                Text {
                    id: _text

                    anchors.centerIn: _recRound

                    text: fText
                    font.pixelSize: Math.min(_root.width, _root.height) / 8.5
                }
            }

            MouseArea {
                anchors.fill: _recRound

                onPressed: {
                    isRun = isRun ? false : true
                    _root.startTimer();

                    if (isRun)
                        _buttonReset.visible = false
                    else
                        _buttonReset.visible = true
                }
            }
        }

        Item {
            width: 1
            height: parent.height / 10
        }

        CustomButton {
            id: _buttonReset

            text: "reset"
            visible: true
            // Layout.alignment: Qt.AlignCenter
            anchors.horizontalCenter: parent.horizontalCenter

            onPressed: {
                _root.resetTimer();
            }
        }
    }
}
