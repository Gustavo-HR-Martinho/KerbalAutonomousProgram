copyPath("0:/libraries/Basic_lib.ks", "1:/libraries/Basic_lib.ks").
copyPath("0:/vehicles/FlyingMite_main.ks", "1:/FlyingMite_main.ks").

runOncePath("1:/libraries/Basic_lib.ks").

initTelemetryLogging().
initMessageLogging().

runOncePath("1:/FlyingMite_main.ks").