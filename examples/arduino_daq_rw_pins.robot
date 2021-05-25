*** Settings ***
Documentation    Read voltage using Arduino DAQ
Suite Setup      Configure Arduino DAQ
Suite Teardown   Close Connection
Library          ../ArduinoDAQLibrary/    device=${device}
Library          Dialogs
Library          BuiltIn

*** Variables ***
${ANALOG_PIN}                 1
${DIGITAL_PIN}                2
${DIGITAL_PIN_WITH_PULLUP}    3
${LED_PIN}                    13

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

LED Turns ON
    Set digital pin ${LED_PIN} FALSE
    Sleep                  5
    Set digital pin ${LED_PIN} TRUE
    Execute Manual Step    The LED was OFF and now is ON

LED Turns OFF
    Set digital pin ${LED_PIN} TRUE
    Sleep                  5
    Set digital pin ${LED_PIN} FALSE
    Execute Manual Step    The LED was ON and now is OFF

*** Keywords ***
Configure Arduino DAQ
    Configure pin ${ANALOG_PIN} as analog input
    Configure pin ${DIGITAL_PIN} as digital input
    Configure pin ${DIGITAL_PIN_WITH_PULLUP} as digital input with pullup
    Configure pin ${LED_PIN} as digital output
