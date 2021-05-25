from pymata4 import pymata4

from robot.api import logger
from robot.api.deco import keyword, library


__version__ = '0.1.0'


@library
class ArduinoDAQLibrary:
    """
    ArduinoDAQLibrary is a library for Robot Framework.

    It provides an API to interact with Arduino-based DAQ. Arduino is running
    the FirmataExpress firmware, see [https://github.com/MrYsLab/pymata4].
    """
    ROBOT_LIBRARY_SCOPE = "SUITE"
    ROBOT_LIBRARY_VERSION = __version__

    def __init__(self, device=''):
        self.device = device
        self._board = None

        if not device:
            raise ArduinoDAQLibraryException("Device is not set")

        logger.info('ArduinoDAQLibrary instance created')

    @property
    def board(self):
        if self._board:
            return self._board
        else:
            self._board = pymata4.Pymata4(com_port=self.device)
            return self._board

    #### Keywords ####

    @keyword
    def close_connection(self):
        if self._board:
            self._board.shutdown()

    @keyword
    def set_sampling_interval(self, interval: int):
        self.board.set_sampling_interval(interval)

    @keyword("Configure pin ${pin_number:\d+} as analog input")
    def configure_pin_as_analog_input(self, pin_number: int):
        self.board.set_pin_mode_analog_input(pin_number)

    @keyword("Configure pin ${pin_number:\d+} as digital input with pullup")
    def configure_pin_as_digital_input_with_pullup(self, pin_number: int):
        self.board.set_pin_mode_digital_input_pullup(pin_number)

    @keyword("Configure pin ${pin_number:\d+} as digital input")
    def configure_pin_as_digital_input(self, pin_number: int):
        self.board.set_pin_mode_digital_input(pin_number)

    @keyword("Configure pin ${pin_number:\d+} as digital output")
    def configure_pin_as_digital_output(self, pin_number: int):
        self.board.set_pin_mode_digital_output(pin_number)

    @keyword("Voltage on pin ${pin_number:\d+}")
    def voltage_on_pin(self, pin_number: int):
        return self.board.analog_read(pin_number)[0]

    @keyword("State of digital pin ${pin_number:\d+}")
    def state_of_digital_pin(self, pin_number: int):
        return self.board.digital_read(pin_number)[0]


class ArduinoDAQLibraryException(Exception):
    pass

