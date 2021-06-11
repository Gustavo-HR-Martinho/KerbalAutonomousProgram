// ╔═════════════════════════════════╗
// ║ GENERAL SYSTEM BOOT SCRIPT v1.0 ║
// ╚═════════════════════════════════╝

// Basic functions library load and execution
copyPath("0:/libraries/BFL.ks", "1:/BFL.ks").
runOncePath("1:/BFL.ks"). logMessage("Basic functions library executed").
initTelemetryFile(). initMessageFile().


// General functions library load and execution
copyPath("0:/libraries/GFL.ks", "1:/GFL.ks").
runOncePath("1:/GFL.ks"). logMessage("General functions library executed").

// Main launch script load and execution
copyPath("0:/vehicles/KAV-S.ks", "1:/KAV-S.ks").
runOncePath("1:/KAV-S.ks").