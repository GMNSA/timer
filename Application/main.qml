import QtQuick 2.12
import QtQuick.Controls 2.5
import PageStopWatch.Impl 1.0
import PageTimer.Impl 1.0
import QtQuick.Controls.Material 2.3

import cus.stopWatch 1.0
import cus.timer 1.0
import QtMultimedia 5.9

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Tabs")

    Material.accent: Material.BlueGrey

    ModuleStopWatch {
        id: _moduleStopWatch

        onTriggerTime: {
            _customStopWatch.fText = display
        }
    }

    ModuleTimer {
        id: _moduleTimer

        onChangeDisplay: {
            _customTimer.fTextRunTimer.text = _moduleTimer.display
            _customTimer.fTextStopTimer = _moduleTimer.display
        }

        onCalculateTime: {
            _customTimer.fTextRunTimer = _moduleTimer.display
        }

        onTriggerTimer: {
            _moduleTimer.timeout();
            _moduleTimer.changeProcent();
            _customTimer.fTextRunTimer = _moduleTimer.display
        }

        onChangeProcent: {
            console.log("change procent");
            _customTimer.fCurrentValue = _moduleTimer.procentRound;
            _customTimer.fMaxValue = _moduleTimer.maxRound();
            console.log("max: " + fMaxValue);
            console.log("current: " + fCurrentValue);
        }
    }

    header: TabBar {
        id: _headerToolBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("StopWatch2")

            onPressed: {
                console.log("stop watch true")
                _customTimer.visible = false
                _customStopWatch.visible = true
            }
        }

        TabButton {
            text: qsTr("Timer")

            onPressed: {
                _customTimer.visible = true
                _customStopWatch.visible = false
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: _headerToolBar.currentIndex

        CustomStopWatch {
            id: _customStopWatch

            onStartTimer: {
                if (!_customStopWatch.isRun)
                    _moduleStopWatch.stop()
                else
                    _moduleStopWatch.start()
            }

            onResetTimer: {
                _moduleStopWatch.reset();
            }
        }

        CustomTimer {
            id: _customTimer
            // visible: false
        }
    }
}
