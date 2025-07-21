import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources

    // Nodes:
    Node {
        id: root
        objectName: "ROOT"
        Model {
            id: f450_frame___Body1_1
            objectName: "f450_frame - Body1-1"
            source: "meshes/f450_frame___Body1_1_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
        Model {
            id: f450_frame___Body2_1
            objectName: "f450_frame - Body2-1"
            source: "meshes/f450_frame___Body2_1_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
        Model {
            id: f450_frame___Body3_1
            objectName: "f450_frame - Body3-1"
            source: "meshes/f450_frame___Body3_1_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
        Model {
            id: f450_frame___Body4_1
            objectName: "f450_frame - Body4-1"
            source: "meshes/f450_frame___Body4_1_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
        Model {
            id: f450_frame___Body5_1
            objectName: "f450_frame - Body5-1"
            source: "meshes/f450_frame___Body5_1_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
        Model {
            id: f450_frame___Body6_1
            objectName: "f450_frame - Body6-1"
            source: "meshes/f450_frame___Body6_1_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
        Model {
            id: f450_frame___H_lice_1045_1
            objectName: "f450_frame - Hélice_1045-1"
            source: "meshes/f450_frame___H_lice_1045_1_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
        Model {
            id: f450_frame___H_lice_1045_2
            objectName: "f450_frame - Hélice_1045-2"
            source: "meshes/f450_frame___H_lice_1045_2_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
        Model {
            id: f450_frame___H_lice_1045_3
            objectName: "f450_frame - Hélice_1045-3"
            source: "meshes/f450_frame___H_lice_1045_3_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
        Model {
            id: f450_frame___H_lice_1045_4
            objectName: "f450_frame - Hélice_1045-4"
            source: "meshes/f450_frame___H_lice_1045_4_mesh.mesh"
            materials: [
                principledMaterial
            ]
        }
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: principledMaterial
            objectName: "principledMaterial"
            metalness: 1
            roughness: 1
            alphaMode: PrincipledMaterial.Opaque
        }
    }

    // Animations:
}
