# Imports
import matplotlib.pyplot as plt
import numpy as np

# Counters
dataCounter = 0
registryCounter = 0

# Data lists
timeLog = []
statusLog = []
radarAltLog = []
desiredAltLog = []
trueAltLog = []
vSpeedLog = []
desiredVSpeedLog = []
hSpeedLog = []
airSpeedLog = []
apoapsisLog = []
throttleLog = []

# Data processing
with open('telemetry.txt', 'r') as dataFile:
    for line in dataFile:
        for data in line.split():
            if(dataCounter % 12 == 0):
                registryCounter += 1
            elif(dataCounter % 12 == 1):
                timeLog.append(float(data))
            elif(dataCounter % 12 == 2):
                statusLog.append(data)
            elif(dataCounter % 12 == 3):
                radarAltLog.append(float(data))
            elif(dataCounter % 12 == 4):
                desiredAltLog.append(float(data))
            elif(dataCounter % 12 == 5):
                trueAltLog.append(float(data))
            elif(dataCounter % 12 == 6):
                vSpeedLog.append(float(data))
            elif(dataCounter % 12 == 7):
                desiredVSpeedLog.append(float(data))
            elif(dataCounter % 12 == 8):
                hSpeedLog.append(float(data))
            elif(dataCounter % 12 == 9):
                airSpeedLog.append(float(data))
            elif(dataCounter % 12 == 10):
                apoapsisLog.append(float(data))
            elif(dataCounter % 12 == 11):
                throttleLog.append(float(data))
            dataCounter += 1

# Data plotting
fig, ((radarAltGraph, vSpeedGraph), (throttleGraph, hSpeedGraph)) = plt.subplots(nrows=2, ncols=2)

# Radar altitude over time graph
radarAltGraph.plot(timeLog, radarAltLog)
radarAltGraph.plot(timeLog, desiredAltLog)
radarAltGraph.set_title('Radar altitude over time')
radarAltGraph.set_xlabel('Mission time (s)')
radarAltGraph.set_ylabel('Radar altitude (m)')

# Vertical speed over time graph
vSpeedGraph.plot(timeLog, vSpeedLog)
vSpeedGraph.plot(timeLog, desiredVSpeedLog)
vSpeedGraph.set_title('Vertical speed over time')
vSpeedGraph.set_xlabel('Mission time (s)')
vSpeedGraph.set_ylabel('Vertical speed (m/s)')

# Throttle over time graph
throttleGraph.plot(timeLog, throttleLog)
throttleGraph.set_title('Throttle over time')
throttleGraph.set_xlabel('Mission time (s)')
throttleGraph.set_ylabel('Throttle')

# Vertical speed over time graph
hSpeedGraph.plot(timeLog, hSpeedLog)
hSpeedGraph.set_title('Horizontal speed over time')
hSpeedGraph.set_xlabel('Mission time (s)')
hSpeedGraph.set_ylabel('Horizontal speed (m/s)')

# Figure processing
fig.tight_layout()
plt.savefig('output.png')