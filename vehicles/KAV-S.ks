logMessage("KAV-S Launch script executed").
// ╔════════════════════════════════════════╗
// ║ KERBAL AUTONOMOUS VEHICLE - SMALL v0.2 ║
// ╚════════════════════════════════════════╝
// ╔════════════════════╗
// ║    Flight steps    ║
// ╠════════════════════╣
// ║ 0 - Pre Flight     ║
// ╟────────────────────╢
// ║ 1 - Launch         ║
// ╟────────────────────╢
// ║ 2 - Ascent         ║
// ╟────────────────────╢
// ║ 3 - Altitude hold  ║
// ╟────────────────────╢
// ║ 4 - Descent        ║
// ╟────────────────────╢
// ║ 5 - Landing        ║
// ╟────────────────────╢
// ║ 6 - Pos Landing    ║
// ╚════════════════════╝
SET launchStep TO 0.

// Test variables
SET testAltitude TO 10.
SET ascentSpeed TO 10.
SET descentSpeed TO -1.
SET hoverDuration TO 10.
SET updateRate TO 0.2.
SET targetAltitude TO 0.

// Raw control
GLOBAL throttleController TO 0.
LOCK throttle TO throttleController.
GLOBAL headingController TO 0.
GLOBAL angleController TO 90.
GLOBAL rollController TO 0.
LOCK steering TO HEADING(headingController, angleController, rollController).

// PID Controllers
SET altP TO 1.
SET altI TO 0.1.
SET altD TO 0.1.
SET altController TO PIDLOOP(altP, altI, altD, descentSpeed, ascentSpeed).
SET vSpdP TO 0.2.
SET vSpdI TO 0.
SET vSpdD TO 0.
SET vSpdController TO PIDLOOP(vSpdP, vSpdI, vSpdD, 0, 1).

// Flight validators
SET hoverValidator TO TRUE.

// Main flight loop
UNTIL FALSE {
    // PID Controllers update
    SET altController:setpoint TO targetAltitude.
    SET desiredVSpeed TO altController:UPDATE(time:seconds, alt:radar).
    SET vSpdController:setpoint TO desiredVSpeed.
    SET desiredThrottle TO vSpdController:UPDATE(time:seconds, ship:verticalspeed).
    SET throttleController TO desiredThrottle.

    logTelemetry(targetAltitude, desiredVSpeed). // Log telemetry

    // Flight steps
    IF(launchStep = 0){ // Pre flight
        // Controls and systems startup
        RCS on.
        LIGHTS off.

        SET targetAltitude TO 0. // Initiate altitude controller setpoint

        SET launchStep TO launchStep + 1. logMessage("Flight step updated to Launch"). // Next launch step
    }ELSE IF(launchStep = 1){ // Launch
        // Set desired hover altitude
        SET targetAltitude TO testAltitude.
        
        STAGE. // Launch !!

        SET launchStep TO launchStep + 1. logMessage("Flight step updated to Ascent").// Next launch step
    }ELSE IF(launchStep = 2){ // Ascent
        IF(alt:radar >= targetAltitude - targetAltitude*0.1){
            SET launchStep TO launchStep + 1. logMessage("Flight step updated to Altitude Hold"). logMessage("Altitude hold duration: " + hoverDuration).// Next launch step
        }
    }ELSE IF(launchStep = 3){ // Altitude Hold
        IF(hoverValidator){
            SET hoverInitTime TO missionTime.
            SET hoverValidator TO FALSE.
        }

        IF(missionTime - hoverInitTime >= hoverDuration){
            SET launchStep TO launchStep + 1. logMessage("Flight step updated to Descent").// Next launch step  
        }      
    }ELSE IF(launchStep = 4){ // Descent
        SET targetAltitude TO 0.

        IF(alt:radar <= testAltitude/2){
            SET launchStep TO launchStep + 1. logMessage("Flight step updated to Landing").// Next launch step
        }
    }ELSE IF(launchStep = 5){ // Landing
        SET descentSpeed TO descentSpeed/2.

        IF(alt:radar <= 0.5){
            SET launchStep TO launchStep + 1. logMessage("Flight step updated to Pos landing").// Next launch step
        }
    }ELSE IF(launchStep = 6){ // Pos flight
        // Controls and systems shutdown
        RCS off.
        UNLOCK throttle.
        UNLOCK steering.

        logMessage("Flight sequence completed"). BREAK. // Next launch step
    }

    WAIT updateRate. // Loop update rate
}

