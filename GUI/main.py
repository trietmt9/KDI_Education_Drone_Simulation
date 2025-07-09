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
        self._motor_pwm = [1500.0, 1500.0, 1500.0, 1500.0]  # 4 motors
        
        # Simulate real-time data updates every 500ms
        self.timer = QTimer()
        self.timer.timeout.connect(self.update_data)
        self.timer.start(100)

    # Properties for roll, pitch, yaw, and altitude
    def get_roll(self):
        return f"{self._roll:.1f}°"

    def get_pitch(self):
        return f"{self._pitch:.1f}°"

    def get_yaw(self):
        return f"{self._yaw:.1f}°"

    def get_altitude(self):
        return f"{self._altitude:.1f} m"

    def get_motor_pwm(self):
        return f"{self._motor_pwm:.0f} μs"

    def get_motor_pwm_value(self):
        return self._motor_pwm
    # Properties for 3D rotation (floats)
    def get_roll_3d(self):
        return self._roll

    def get_pitch_3d(self):
        return self._pitch

    def get_yaw_3d(self):
        return self._yaw

    def get_altitude_3d(self):
        return self._altitude
    
    def get_motor_pwm(self):
        # Return as string for display
        return " | ".join([f"{pwm:.0f} μs" for pwm in self._motor_pwm])

    def get_motor_pwm_values(self):
        return self._motor_pwm


    def simulate_motor_pwm(self):
        min_pwm = 1500
        max_pwm = 2500
        base_pwm = 2000  # Neutral throttle
        max_angle = 45.0  # Assume max angle for full effect

        # Normalize angles to [-1, 1]
        roll_norm = max(-1, min(1, self._roll / max_angle))
        pitch_norm = max(-1, min(1, self._pitch / max_angle))
        yaw_norm = max(-1, min(1, self._yaw / max_angle))

        # Mix for each motor
        m1 = base_pwm + 200 * pitch_norm + 200 * roll_norm - 200 * yaw_norm
        m2 = base_pwm + 200 * pitch_norm - 200 * roll_norm + 200 * yaw_norm
        m3 = base_pwm - 200 * pitch_norm - 200 * roll_norm - 200 * yaw_norm
        m4 = base_pwm - 200 * pitch_norm + 200 * roll_norm + 200 * yaw_norm

        # Clamp to [min_pwm, max_pwm]
        self._motor_pwm = [
            max(min_pwm, min(max_pwm, m1)),
            max(min_pwm, min(max_pwm, m2)),
            max(min_pwm, min(max_pwm, m3)),
            max(min_pwm, min(max_pwm, m4)),
        ]
    # Simulate drone data (replace with real sensor data)
    def update_data(self):

        if self.ser and self.ser.in_waiting:
            try:
                line = self.ser.readline().decode('utf-8').strip()
                # Example line: ROLL:12.3,PITCH:-5.6,YAW:45.0,ALT:23.4
                parts = line.split(',')
                data = {}
                for part in parts:
                    if ':' in part:
                        key, value = part.split(':', 1)
                        data[key.strip().upper()] = float(value.strip())
                self._roll = data.get('ROLL', self._roll)
                self._pitch = data.get('PITCH', self._pitch)
                self._yaw = data.get('YAW', self._yaw)
                self._altitude = data.get('ALT', self._altitude)
            except Exception as e:
                print(f"Serial read/parse error: {e}")
        
        # Emit signals to notify QML of changes
        self.roll_changed.emit()
        self.pitch_changed.emit()
        self.yaw_changed.emit()
        self.altitude_changed.emit()
        self.motor_pwm_changed.emit()
    # Signals for QML updates
    from PySide6.QtCore import Signal
    roll_changed = Signal()
    pitch_changed = Signal()
    yaw_changed = Signal()
    altitude_changed = Signal()
    motor_pwm_changed = Signal()

    roll = Property(str, get_roll, notify=roll_changed)
    roll_3d = Property(float, get_roll_3d, notify=roll_changed)

    pitch = Property(str, get_pitch, notify=pitch_changed)
    pitch_3d = Property(float, get_pitch_3d, notify=pitch_changed)

    yaw = Property(str, get_yaw, notify=yaw_changed)
    yaw_3d = Property(float, get_yaw_3d, notify=yaw_changed)

    altitude = Property(str, get_altitude, notify=altitude_changed)
    altitude_3d = Property(float, get_altitude_3d, notify=altitude_changed)
    
    motor_pwm = Property(str, get_motor_pwm, notify=motor_pwm_changed)
    motor_pwm_values = Property('QVariantList', get_motor_pwm_values, notify=motor_pwm_changed)

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
