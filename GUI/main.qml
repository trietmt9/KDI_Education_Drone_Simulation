import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D
import "file:/home/stephen/Documents/PyQt_DroneDisplay/GUI/UntitledProject/Generated/QtQuick3D/Drone"
ApplicationWindow {
    visibility: Window.FullScreen
    width: 800
    height: 400
    title: "Drone Dashboard"

    Rectangle {
        anchors.fill: parent
        color: "#424242"

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
                    text: "Yaw: " + droneData.yaw
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
                Layout.alignment: Qt.AlignHCenter  // Center the View3D horizontally
                Layout.fillWidth: true            // Make it fill the available width
                Layout.fillHeight: true           // Make it fill the available height
                environment: SceneEnvironment {
                    clearColor: "#424242"
                }
                 SceneEnvironment {
                    id: sceneEnvironment
                    antialiasingMode: SceneEnvironment.MSAA
                    antialiasingQuality: SceneEnvironment.High
                }

                Node {
                    id: scene
                    DirectionalLight {
                        id: directionalLight
                        brightness: 3.96
                        eulerRotation.z: 0
                        eulerRotation.y: 0
                        eulerRotation.x: 0
                    }

                    PerspectiveCamera {
                        id: sceneCamera
                        z: 350
                        // position: Qt.vector3d(0, 0, 350)  // Camera position (z = 350 ensures the drone fits in view)
                        // lookAt: drone.position            // Focus on the drone's position
                        // fieldOfView: 45                   // Adjust FOV for better framing
                    }

                    Drone {
                        id: drone
                        position: Qt.vector3d(0, 0, 0)    // Center the drone at the origin
                        scale: Qt.vector3d(0.5, 0.5, 0.5)
                        x: -360
                        y: -170
                        z: -270
                        eulerRotation.z: droneData.yaw_3d
                        eulerRotation.y: droneData.pitch_3d
                        eulerRotation.x: droneData.roll_3d
                        onEulerRotationChanged: console.log("Drone rotation updated:", eulerRotation)
                    }
                }
            }
        }
    }
}