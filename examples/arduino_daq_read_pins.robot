*** Settings ***
Documentation    Read voltage using Arduino DAQ
Suite Setup      Configure Arduino DAQ
Suite Teardown   Close Connection
Library          ../ArduinoDAQLibrary/    device=${device}

*** Variables ***
${ANALOG_PIN}                 1
${DIGITAL_PIN}                2
${DIGITAL_PIN_WITH_PULLUP}    3

*** Test Cases ***
Read Analog Voltage
    ${voltage} =      Voltage on pin ${ANALOG_PIN}
    Log To Console    ${voltage}

Read State of Digital Pin Without Pullup
    ${voltage} =      State of digital pin ${DIGITAL_PIN}
    Log To Console    ${voltage}

Read State of Digital Pin With Pullup
    ${voltage} =      State of digital pin ${DIGITAL_PIN_WITH_PULLUP}
    Log To Console    ${voltage}

*** Keywords ***
Configure Arduino DAQ
    Configure pin ${ANALOG_PIN} as analog input
    Configure pin ${DIGITAL_PIN} as digital input
    Configure pin ${DIGITAL_PIN_WITH_PULLUP} as digital input with pullup
