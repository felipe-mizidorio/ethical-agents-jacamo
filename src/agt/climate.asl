// Agent climate

/* Initial beliefs and rules */

/* Initial goals */
!verifySeason.

/* Plans */
+!verifySeason : true
    <-  .print("Agent climate: verifying weather...");
        verifySeason(Season);
        if(Season == "Winter") {
            .print("Agent climate: it is winter!");
            .send(ant, tell, isWinter);
        } else {
            .print("Agent climate: it is not winter!");
            .send(ant, tell, ~isWinter);
        }
        .wait(10);
        nextSeason;
        !verifySeason.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }