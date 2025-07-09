import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D
import "Generated/QtQuick3D/Drone"

ApplicationWindow {
    visibility: Window.FullScreen
    width: 1200
    height: 800
    title: "Drone Dashboard"

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1a1a1a" }
            GradientStop { position: 1.0; color: "#2d2d2d" }
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            // Left Panel - Data Display
            Rectangle {
                Layout.preferredWidth: 350
                Layout.fillHeight: true
                color: "#1e1e1e"
                radius: 15
                border.color: "#444444"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    // Header
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 60
                        color: "#00E676"
                        radius: 10

                        Text {
                            anchors.centerIn: parent
                            text: "DRONE STATUS"
                            font.pixelSize: 18
                            font.bold: true
                            color: "#1a1a1a"
                        }
                    }

                    // Telemetry Data
                    GridLayout {
                        Layout.fillWidth: true
                        columns: 1
                        rowSpacing: 15

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 80
                            color: "#2a2a2a"
                            radius: 8
                            border.color: "#00E676"
                            border.width: 1

                            Column {
                                anchors.centerIn: parent
                                spacing: 5

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "ROLL"
                                    font.pixelSize: 14
                                    color: "#888888"
                                }
                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: droneData.roll
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "#00E676"
                                }
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 80
                            color: "#2a2a2a"
                            radius: 8
                            border.color: "#FF9800"
                            border.width: 1

                            Column {
                                anchors.centerIn: parent
                                spacing: 5

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "PITCH"
                                    font.pixelSize: 14
                                    color: "#888888"
                                }
                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: droneData.pitch
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "#FF9800"
                                }
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 80
                            color: "#2a2a2a"
                            radius: 8
                            border.color: "#2196F3"
                            border.width: 1

                            Column {
                                anchors.centerIn: parent
                                spacing: 5

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "YAW"
                                    font.pixelSize: 14
                                    color: "#888888"
                                }
                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: droneData.yaw
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "#2196F3"
                                }
                            }
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 100
                            color: "#232323"
                            radius: 8
                            border.color: "#00B0FF"
                            border.width: 1

                            Column {
                                anchors.centerIn: parent
                                spacing: 5

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "MOTOR PWM"
                                    font.pixelSize: 14
                                    color: "#00B0FF"
                                }
                                Row {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    spacing: 12
                                    Repeater {
                                        model: droneData.motor_pwm_values.length
                                        delegate: Column {
                                            spacing: 2
                                            Text {
                                                text: "M" + (index + 1)
                                                font.pixelSize: 12
                                                color: "#888888"
                                                horizontalAlignment: Text.AlignHCenter
                                            }
                                            Text {
                                                text: Math.round(droneData.motor_pwm_values[index]) + " μs"
                                                font.pixelSize: 18
                                                font.bold: true
                                                color: "#00B0FF"
                                                horizontalAlignment: Text.AlignHCenter
                                            }
                                        }
                                    }
                                }
                           }
                        }
                    }

                    Item { Layout.fillHeight: true }

                    // Status Indicator
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        color: "#4CAF50"
                        radius: 20

                        Row {
                            anchors.centerIn: parent
                            spacing: 10

                            Rectangle {
                                width: 12
                                height: 12
                                radius: 6
                                color: "white"
                                
                                SequentialAnimation on opacity {
                                    loops: Animation.Infinite
                                    NumberAnimation { to: 0.3; duration: 1000 }
                                    NumberAnimation { to: 1.0; duration: 1000 }
                                }
                            }

                            Text {
                                text: "CONNECTED"
                                font.pixelSize: 14
                                font.bold: true
                                color: "white"
                            }
                        }
                    }
                }
            }

            // Right Panel - 3D Visualization
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#1e1e1e"
                radius: 15
                border.color: "#444444"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    // Header
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "3D VISUALIZATION"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#00E676"
                    }

                    // 3D View
                    View3D {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        environment: SceneEnvironment {
                            clearColor: "#0a0a0a"
                            backgroundMode: SceneEnvironment.Color
                            antialiasingMode: SceneEnvironment.MSAA
                            antialiasingQuality: SceneEnvironment.High
                        }

                        Node {
                            id: scene

                            DirectionalLight {
                                id: directionalLight
                                brightness: 4.5
                                eulerRotation.x: -30
                                eulerRotation.y: 30
                                color: "#ffffff"
                            }

                            DirectionalLight {
                                id: fillLight
                                brightness: 2.0
                                eulerRotation.x: 30
                                eulerRotation.y: -30
                                color: "#4488ff"
                            }

                            PerspectiveCamera {
                                id: sceneCamera
                                z: 350
                                fieldOfView: 45
                            }

                            Drone {
                                id: drone
                                position: Qt.vector3d(0, 0, 0)
                                scale: Qt.vector3d(0.6, 0.6, 0.6)
                                eulerRotation.z: droneData.yaw_3d
                                eulerRotation.y: droneData.pitch_3d
                                eulerRotation.x: droneData.roll_3d

                                Behavior on eulerRotation {
                                    Vector3dAnimation {
                                        duration: 100
                                        easing.type: Easing.OutQuad
                                    }
                                }
                            }

                            // Grid floor
                            Model {
                                source: "#Rectangle"
                                scale: Qt.vector3d(10, 10, 1)
                                y: -100
                                eulerRotation.x: -90
                                materials: PrincipledMaterial {
                                    baseColor: "#333333"
                                    roughness: 0.8
                                    opacity: 0.3
                                }
                            }
                        }
                    }

                    // Control hints
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Real-time drone orientation visualization"
                        font.pixelSize: 12
                        color: "#888888"
                        opacity: 0.7
                    }
                }
            }
        }
    }
}