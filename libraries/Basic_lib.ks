function initTelemetryLogging {
    if (exists("0:/logs/" + shipName + "/telemetry.txt")) { deletePath("0:/logs/" + shipName + "/telemetry.txt"). }
    create("0:/logs/" + shipName + "/telemetry.txt").
    global telemetryFile to "0:/logs/" + shipName + "/telemetry.txt".
}
function initMessageLogging {
    if (exists("0:/logs/" + shipName + "/message.txt")) { deletePath("0:/logs/" + shipName + "/message.txt"). }
    create("0:/logs/" + shipName + "/message.txt").
    global messageFile to "0:/logs/" + shipName + "/message.txt".
}

function logMessage {
    parameter message.

    print("T-" + round(missionTime, 4) + " | " + message + ".").
    log("T-" + round(missionTime, 4) + " | " + message + ".") to messageFile.
}