// ╔══════════════════════════════╗
// ║ BASIC FUNCTIONS LIBRARY v0.1 ║
// ╚══════════════════════════════╝

FUNCTION initTelemetryFile {
    IF(EXISTS("0:/logs/telemetry.txt")){
        DELETEPATH("0:/logs/telemetry.txt").
        
    }
    CREATE("0:/logs/telemetry.txt").
    GLOBAL telemetryFile TO "0:/logs/telemetry.txt".
}
FUNCTION initMessageFile {
    IF(EXISTS("0:/logs/message.txt")){
        DELETEPATH("0:/logs/message.txt").
        
    }
    CREATE("0:/logs/message.txt").
    GLOBAL messageFile TO "0:/logs/message.txt".
}

FUNCTION logMessage {
    PARAMETER message.
    PRINT "T-" + ROUND(missionTime, 2) + ": " + message + ".".
    LOG "T-" + ROUND(missionTime, 2) + ": " + message + "." TO messageFile.
}
FUNCTION logTelemetry {
    // Telemetry data format
    // flightTime, status, 
    // radarAltitude, desiredAltitude, altitude
    // vertical speed, desiredVspeed, horizontal speed, airspeed
    // apoapsis
    // throttle, desiredThrottle

    parameter desiredAltitude.
    parameter desiredVspeed.

    LOG "! " + ROUND(missionTime, 3) + " " + ship:status TO telemetryFile.
    LOG ROUND(alt:radar, 3) + " " + ROUND(desiredAltitude, 3) + " " + ROUND(ship:altitude, 3) TO telemetryFile.
    LOG ROUND(ship:verticalspeed, 3) + " " + ROUND(desiredVspeed, 3) + " " + ROUND(ship:groundspeed, 3) + " " + ROUND(ship:airspeed, 3) TO telemetryFile.
    LOG ROUND(ship:apoapsis, 3) TO telemetryFile.
    LOG ROUND(throttleController, 3) TO telemetryFile.
}