// Agent climate

/* Initial beliefs and rules */
antIsReady.
grasshopperIsReady.

everybodyReady :- antIsReady & grasshopperIsReady.

/* Initial goals */
!verifySeason.

/* Plans */
+!verifySeason : everybodyReady
    <-  .print("Agent climate: verifying weather...");
        verifySeason(Season);
        if(Season == "Winter") {
            .print("Agent climate: it is winter!");
            .broadcast(tell, isWinter);
            .broadcast(untell, isSummer);
        } else {
            .print("Agent climate: it is summer!");
            .broadcast(tell, isSummer);
            .broadcast(untell, isWinter);
        }
        .wait(500);
        nextSeason;
        !verifySeason.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }