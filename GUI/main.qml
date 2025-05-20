import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D

ApplicationWindow {
    visibility: Window.FullScreen
    width: 800  // Fits a typical 7-inch Raspberry Pi touchscreen
    height: 400
    title: "Drone Dashboard"

    // Tesla-inspired dark theme
    Rectangle {
        anchors.fill: parent
        color: "#212121"  // Dark gray background

        RowLayout {
            anchors.fill: parent
            spacing: 10

            // Center Section: Quadcopter Visualization
            Rectangle {
                Layout.preferredWidth: parent.width
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
                    // Spacer to push info down
            Item { Layout.preferredHeight: 150 }

            // Info Row
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 40

                Text {
                    text: "Roll: " + droneData.roll
                    font.pixelSize: 30
                    color: "#00E676"
                }
                Text {
                    text: "Pitch: " + droneData.pitch
                    font.pixelSize: 30
                    color: "#00E676"
                }
                Text {
                    text: "Altitude: " + droneData.altitude
                    font.pixelSize: 30
                    color: "#00E676"
                }
            }


            // Center Section: 3D Drone Visualization

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    
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
            }
        }
    }
}