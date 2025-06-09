import os
os.environ["QML_IMPORT_PATH"] = "/home/stephen/Qt/6.6.0/gcc_64/qml"
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl, QObject, Slot, Property, QTimer
from PySide6.QtGui import QGuiApplication
import sys
import random

import PySide6
print(PySide6.__version__)
class DroneDataProvider(QObject):
    def __init__(self):
        super().__init__()
        self._roll = 0.0
        self._pitch = 0.0
        self._yaw = 0.0
        self._altitude = 0.0

        # Simulate real-time data updates every 500ms
        self.timer = QTimer()
        self.timer.timeout.connect(self.update_data)
        self.timer.start(1)

    # Properties for roll, pitch, yaw, and altitude
    def get_roll(self):
        return f"{self._roll:.1f}°"

    def get_pitch(self):
        return f"{self._pitch:.1f}°"

    def get_yaw(self):
        return f"{self._yaw:.1f}°"

    def get_altitude(self):
        return f"{self._altitude:.1f} m"

    # Properties for 3D rotation (floats)
    def get_roll_3d(self):
        return self._roll

    def get_pitch_3d(self):
        return self._pitch

    def get_yaw_3d(self):
        return self._yaw

    def get_altitude_3d(self):
        return self._altitude
    
    # Simulate drone data (replace with real sensor data)
    def update_data(self):
        self._roll = random.uniform(-30, 30)  # Mock roll angle
        self._pitch = random.uniform(-30, 30)  # Mock pitch angle
        self._yaw = random.uniform(-180, 180)  # Mock yaw angle
        self._altitude = random.uniform(0, 100)  # Mock altitude
        
        # Emit signals to notify QML of changes
        self.roll_changed.emit()
        self.pitch_changed.emit()
        self.yaw_changed.emit()
        self.altitude_changed.emit()

    # Signals for QML updates
    from PySide6.QtCore import Signal
    roll_changed = Signal()
    pitch_changed = Signal()
    yaw_changed = Signal()
    altitude_changed = Signal()

    roll = Property(str, get_roll, notify=roll_changed)
    roll_3d = Property(float, get_roll_3d, notify=roll_changed)

    pitch = Property(str, get_pitch, notify=pitch_changed)
    pitch_3d = Property(float, get_pitch_3d, notify=pitch_changed)

    yaw = Property(str, get_yaw, notify=yaw_changed)
    yaw_3d = Property(float, get_yaw_3d, notify=yaw_changed)

    altitude = Property(str, get_altitude, notify=altitude_changed)
    altitude_3d = Property(float, get_altitude_3d, notify=altitude_changed)
    
def main():


    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    # Create drone data provider
    drone_data = DroneDataProvider()
    engine.rootContext().setContextProperty("droneData", drone_data)

    # Load QML file
    engine.load(QUrl.fromLocalFile("main.qml"))
    if not engine.rootObjects():
        print("Failed to load QML file")
        sys.exit(-1)

    sys.exit(app.exec())
if __name__ == "__main__":
    main()
