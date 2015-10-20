# Workflow für Inbetriebnahme
1. Namen setzen
2. Input beschriften (Analog/Digital Sensor)
3. Output beschriften (Relay)


# Rules
If <temperature> is <higher than> <100> then ensure <heating-relay> is <off>
If <movement> is <equal> <1> then ensure <light-relay> is <on>

# Advanced Rules
If <movement> is <equal> <0> for <5 minutes> then ensure <light-relay> is <off>
