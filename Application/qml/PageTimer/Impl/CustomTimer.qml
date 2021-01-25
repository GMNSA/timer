import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import CustomButton.Impl 1.0
import PageTimer.CustomRunTimer.Impl 1.0
import PageTimer.CustomStopTimer.Impl 1.0

Page {
    id: _root

    property string fNum: ""
    property string fTextRunTimer: "00:00:00"
    property string fTextStopTimer: "00:00:00"
    property alias fVisibleStopTimer: _stopTimer.visible
    // property alias fVisibleStartTimer: _startTimer.visible
    property alias fVisibleStartTimer: _columnStartTimer.visible
    property bool fIsRun: false
    property alias fCurrentValue: _startTimer.currentValue
    property alias fMaxValue: _startTimer.maximumValue

    width: 640
    height: 480

    CustomStopTimer {
        id: _stopTimer
        visible: true

        text: fTextStopTimer
    }

    Column {
        id: _columnStartTimer

        visible: false
        anchors.fill: parent
        spacing: 3

        Item {
            height: parent.height / 5
            width: 100
        }

        CustomRunTimer {
            id: _startTimer

            // visible: false
            anchors.horizontalCenter: parent.horizontalCenter

            text: fTextRunTimer
            currentValue: _moduleTimer.procentRound;
        }

        Item {
            height: parent.height / 12
            width: 100
        }

        CustomButton {
            id: _buttonDelete

            text: "Delete"
            anchors.top: _stopTimer.bottom
            // anchors.topMargin: parent.height / 7
            anchors.horizontalCenter: parent.horizontalCenter

            width: {
                if (_root.width > 100)
                    100
                else
                    _root.width / 3
            }

            height: {
                if (_root.height / 7 > 50)
                    50
                else
                    _root.height / 7
            }

            onPressed: {
                _moduleTimer.stop()
                _stopTimer.visible = true
                _columnStartTimer.visible = false
                // _customTimer.visible = true
                // _columnStopTimer.visible = true
            }
        }
    }
}
