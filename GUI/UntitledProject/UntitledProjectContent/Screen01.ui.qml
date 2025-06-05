

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import QtQuick3D
import QtQuick3D.Effects
import UntitledProject
import Generated.QtQuick3D.Drone

Rectangle {
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor
    Rectangle {
        Text {}
    }

    View3D {
        id: view3D
        anchors.fill: parent
        anchors.leftMargin: 39
        anchors.rightMargin: -39
        anchors.topMargin: -35
        anchors.bottomMargin: 35

        environment: sceneEnvironment

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
            }

            Drone {
                id: drone
                x: -360
                y: -170
                z: -270
                eulerRotation.z: -179.99902
                eulerRotation.y: -179.99899
                eulerRotation.x: 88.8009
            }
        }
    }

    Item {
        id: __materialLibrary__
        PrincipledMaterial {
            id: defaultMaterial
            objectName: "Default Material"
            baseColor: "#4aee45"
        }
    }
}

/*##^##
Designer {
    D{i:0;matPrevEnvDoc:"SkyBox";matPrevEnvValueDoc:"preview_studio";matPrevModelDoc:"#Sphere"}
D{i:5;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/

