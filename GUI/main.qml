import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 800  // Fits a typical 7-inch Raspberry Pi touchscreen
    height: 480
    title: "Drone Dashboard"

    // Tesla-inspired dark theme
    Rectangle {
        anchors.fill: parent
        color: "#212121"  // Dark gray background

        RowLayout {
            anchors.fill: parent
            spacing: 10

            // Left Section: Drone Status (Angles or Altitude)
            Rectangle {
                Layout.preferredWidth: parent.width * 0.3
                Layout.fillHeight: true
                color: "#424242"
                radius: 10

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text {
                        id: statusTitle
                        Layout.alignment: Qt.AlignHCenter
                        text: "Drone Status"
                        font.pixelSize: 20
                        color: "white"
                    }

                    // Display toggles between angles and altitude
                    ColumnLayout {
                        id: statusDisplay
                        visible: displayMode === "angles"
                        spacing: 5

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: "Roll: " + droneData.roll
                            font.pixelSize: 18
                            color: "#00E676"  // Tesla-like green accent
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: "Pitch: " + droneData.pitch
                            font.pixelSize: 18
                            color: "#00E676"
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: "Yaw: " + droneData.yaw
                            font.pixelSize: 18
                            color: "#00E676"
                        }
                    }

                    Text {
                        id: altitudeDisplay
                        visible: displayMode === "altitude"
                        Layout.alignment: Qt.AlignHCenter
                        text: "Altitude: " + droneData.altitude
                        font.pixelSize: 24
                        color: "#00E676"
                    }
                }
            }

            // Center Section: Quadcopter Visualization
            Rectangle {
                Layout.preferredWidth: parent.width * 0.4
                Layout.fillHeight: true
                color: "#424242"
                radius: 10

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Quadcopter View"
                        font.pixelSize: 20
                        color: "white"
                    }

                    // Quadcopter representation with 4 propellers
                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        // Container for yaw rotation (around Z-axis)
                        Item {
                            id: yawContainer
                            anchors.centerIn: parent
                            rotation: parseFloat(droneData.yaw)  // Yaw rotation

                            // Container for roll and pitch (tilting)
                            Item {
                                id: tiltContainer
                                anchors.centerIn: parent
                                rotation: parseFloat(droneData.roll)  // Roll (X-axis tilt)

                                transform: Rotation {
                                    axis { x: 1; y: 0; z: 0 }
                                    angle: parseFloat(droneData.pitch)  // Pitch (Y-axis tilt)
                                }

                                // Quadcopter body (central square)
                                Rectangle {
                                    id: quadcopterBody
                                    width: 60
                                    height: 60
                                    color: "#00E676"
                                    anchors.centerIn: parent
                                }

                                // Propeller 1 (Top-left in X config)
                                Rectangle {
                                    width: 20
                                    height: 20
                                    radius: 10  // Circular propeller
                                    color: "gray"
                                    x: quadcopterBody.x - 20
                                    y: quadcopterBody.y - 20
                                }

                                // Propeller 2 (Top-right in X config)
                                Rectangle {
                                    width: 20
                                    height: 20
                                    radius: 10
                                    color: "gray"
                                    x: quadcopterBody.x + quadcopterBody.width
                                    y: quadcopterBody.y - 20
                                }

                                // Propeller 3 (Bottom-left in X config)
                                Rectangle {
                                    width: 20
                                    height: 20
                                    radius: 10
                                    color: "gray"
                                    x: quadcopterBody.x - 20
                                    y: quadcopterBody.y + quadcopterBody.height
                                }

                                // Propeller 4 (Bottom-right in X config)
                                Rectangle {
                                    width: 20
                                    height: 20
                                    radius: 10
                                    color: "gray"
                                    x: quadcopterBody.x + quadcopterBody.width
                                    y: quadcopterBody.y + quadcopterBody.height
                                }
                            }
                        }
                    }
                }
            }

            // Right Section: Controls (Toggle between Angles and Altitude)
            Rectangle {
                Layout.preferredWidth: parent.width * 0.3
                Layout.fillHeight: true
                color: "#424242"
                radius: 10

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 15

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Controls"
                        font.pixelSize: 20
                        color: "white"
                    }

                    // Button to show angles
                    Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 60
                        text: "Show Angles"
                        font.pixelSize: 18
                        background: Rectangle {
                            color: displayMode === "angles" ? "#00E676" : "#616161"
                            radius: 5
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: displayMode === "angles" ? "black" : "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: displayMode = "angles"
                    }

                    // Button to show altitude
                    Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 60
                        text: "Show Altitude"
                        font.pixelSize: 18
                        background: Rectangle {
                            color: displayMode === "altitude" ? "#00E676" : "#616161"
                            radius: 5
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: displayMode === "altitude" ? "black" : "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: displayMode = "altitude"
                    }
                }
            }
        }
    }

    // State variable to toggle between angles and altitude display
    property string displayMode: "angles"
}