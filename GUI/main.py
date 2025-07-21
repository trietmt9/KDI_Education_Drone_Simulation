import sys
import re
import serial
import threading
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl, QObject, Property, Signal
from PySide6.QtGui import QGuiApplication

SERIAL_PORT = '/dev/ttyAMA0'  # Change if needed
BAUD_RATE = 9600
pattern = re.compile(r"(-?\d+),\s*(-?\d+),\s*(-?\d+(?:\.\d+)?)")

class DroneDataProvider(QObject):
    roll_changed = Signal()
    pitch_changed = Signal()
    yaw_changed = Signal()
    altitude_changed = Signal()

    def __init__(self):
        super().__init__()
        self._roll = 0.0
        self._pitch = 0.0
        self._yaw = 0.0
        self._altitude = 0.0
        try:
            self.ser = serial.Serial(
                port=SERIAL_PORT,
                baudrate=BAUD_RATE,
                parity=serial.PARITY_NONE,
                stopbits=serial.STOPBITS_ONE,
                bytesize=serial.EIGHTBITS,
                timeout=1
            )
        except serial.SerialException as e:
            print(f"Serial port error: {e}")
            self.ser = None
        # Start background thread for serial reading
        self._stop_thread = False
        self._thread = threading.Thread(target=self._serial_reader, daemon=True)
        self._thread.start()

    def _serial_reader(self):
        while not self._stop_thread and self.ser:
            try:
                line = self.ser.readline().decode('utf-8').strip()
                match = pattern.match(line)
                if match:
                    roll = float(match.group(1))
                    pitch = float(match.group(2))
                    yaw = float(match.group(3))
                    # Only emit if values changed for efficiency
                    if (roll != self._roll or pitch != self._pitch or yaw != self._yaw):
                        self._roll = roll
                        self._pitch = pitch
                        self._yaw = yaw
                        self.roll_changed.emit()
                        self.pitch_changed.emit()
                        self.yaw_changed.emit()
                        self.altitude_changed.emit()
            except Exception as e:
                print(f"Serial read error: {e}")

    def get_roll(self):
        return f"{self._roll:.1f}°"
    def get_pitch(self):
        return f"{self._pitch:.1f}°"
    def get_yaw(self):
        return f"{self._yaw:.1f}°"
    def get_altitude(self):
        return f"{self._altitude:.1f} m"
    def get_roll_3d(self):
        return self._roll
    def get_pitch_3d(self):
        return self._pitch
    def get_yaw_3d(self):
        return self._yaw
    def get_altitude_3d(self):
        return self._altitude

    roll = Property(str, get_roll, notify=roll_changed)
    roll_3d = Property(float, get_roll_3d, notify=roll_changed)
    pitch = Property(str, get_pitch, notify=pitch_changed)
    pitch_3d = Property(float, get_pitch_3d, notify=pitch_changed)
    yaw = Property(str, get_yaw, notify=yaw_changed)
    yaw_3d = Property(float, get_yaw_3d, notify=yaw_changed)
    altitude = Property(str, get_altitude, notify=altitude_changed)
    altitude_3d = Property(float, get_altitude_3d, notify=altitude_changed)

    def __del__(self):
        self._stop_thread = True
        if hasattr(self, 'ser') and self.ser:
            self.ser.close()

def main():
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    drone_data = DroneDataProvider()
    engine.rootContext().setContextProperty("droneData", drone_data)
    engine.load(QUrl.fromLocalFile("main.qml"))
    if not engine.rootObjects():
        print("Failed to load QML file")
        sys.exit(-1)
    sys.exit(app.exec())

if __name__ == "__main__":
    main()
