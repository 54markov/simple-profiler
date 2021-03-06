import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

import baseProfiler 0.1

ApplicationWindow {
    id: window
    width: 1024
    height: 768
    visible: true

    MessageDialog {
        id: aboutMsgDialog
        title: "About Text"
        text: "This is a basic tool to profile your c/c++ code.\nWritten with Qt Quick Controls 2.4 by Markov V.A."
        icon: StandardIcon.Information
    }

    BaseProfiler
    {
        id: baseProfiler
        onResultChanged: textArea.text = getResult
    }

    ScrollView
    {
        id: scrollView
        anchors.fill: parent

        TextArea {
            id: textArea
            textFormat: Text.RichText
            font.family: "Courier"
            anchors.margins: 1
        }
    }

    FileDialog {
        id: memDialog
        title: "Please choose a file"
        onAccepted:
        {
            onAccepted: baseProfiler.runMemoryCheck(memDialog.fileUrl.toString().replace("file://", ""))
        }
    }

    FileDialog {
        id: samplingDialog
        title: "Please choose a file"
        onAccepted:
        {
            onAccepted: baseProfiler.runPerfomanceSampleCheck(samplingDialog.fileUrl.toString().replace("file://", ""))
        }
    }

    FileDialog {
        id: hwEventsDialog
        title: "Please choose a file"
        onAccepted:
        {
            onAccepted: baseProfiler.runPerfomanceEventCheck(hwEventsDialog.fileUrl.toString().replace("file://", ""))
        }
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&Menu")
            MenuItem
            {
                text: "About" ;
                onTriggered: aboutMsgDialog.open()
            }

            MenuSeparator { }

            MenuItem
            {
                text: "Quit"
                onTriggered: Qt.quit()
            }
        }

        MenuSeparator { }

        Menu {
            title: qsTr("Memory Profiler")
            MenuItem
            {
                text: qsTr("&Memory leaks")
                onTriggered: memDialog.open()
            }
        }

        MenuSeparator { }

        Menu {
            title: qsTr("Perfomance Profiler")
            MenuItem
            {
                text: qsTr("&Sampling")
                onTriggered: samplingDialog.open()
            }

            MenuItem
            {
                text: qsTr("&HW-events")
                onTriggered: hwEventsDialog.open()
            }
        }
    }
}
