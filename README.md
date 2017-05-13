# Firewerx

Proof of Concept service running on a Raspberry Pi that can control LED's via GPIO and I2C protocol.
 
### Stage One
A Phoenix service installed and responding to /ping endpoint

### Stage Two
Service blinks an LED while running

Use Periodic Actor (example)

### Stage Three
Endpoint can manipulate a second LED

HTTP POST /led 

on / off in body (some structured data)

### Stage Four 
Endpoint can cycle between various patterns on Pixel Matrix

HTTP POST /matrix

{ pattern: n }

### Stage Five
Endpoint accepts 8x8 matrix to determine set display state

HTTP POST /matrix/raw

[ [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ]]
