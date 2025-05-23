import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D

ApplicationWindow {
    visibility: Window.FullScreen
    width: 800
    height: 400
    title: "Drone Dashboard"

    Rectangle {
        anchors.fill: parent
        color: "#212121"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            // Title
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Quadcopter View"
                font.pixelSize: 24
                color: "white"
            }

            // Spacer to push info down
            Item { Layout.preferredHeight: 20 }

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

            // Spacer to push 3D view down
            Item { Layout.preferredHeight: 20 }

            // 3D Drone Visualization
            View3D {
                Layout.fillWidth: true
                Layout.fillHeight: true
                environment: SceneEnvironment {
                    backgroundMode: SceneEnvironment.Color
                    clearColor: "#424242"
                }
                PerspectiveCamera {
                    id: camera
                    position: Qt.vector3d(0, 0, 20)
                }
                DirectionalLight {
                    eulerRotation.x: -45
                    brightness: 10
                }
                Model {
                    source: "assets/.glb"
                    scale: Qt.vector3d(10, 10, 10)
                    // Optionally, bind rotation to your telemetry
                    // eulerRotation.x: parseFloat(droneData.roll)
                    // eulerRotation.y: parseFloat(droneData.pitch)
                    // eulerRotation.z: parseFloat(droneData.yaw)
                }
            }
        }
    }
}