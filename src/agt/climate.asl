// Agent climate
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moise/asl/org-obedient.asl") }

/* Initial beliefs and rules */

/* Initial goals */
!waitAgents.

/* Plans */
+!waitAgents: true
    <-  .wait(1000);
        seasonIncrement;
        verifySeasonCounter(X);
        if(X == 1) {
            .print("Agent climate: it is summer!");
            .broadcast(tell, season("Summer"));
        }
        !verifySeason.

+!verifySeason : true
    <-  .print("Agent climate: verifying weather...");
        verifySeason(Season);
        if(Season == "Winter") {
            .print("Agent climate: it is winter!");
            .broadcast(untell, season("Summer"));
            .broadcast(tell, season(Season));
        } else {
            .print("Agent climate: it is summer!");
            .broadcast(untell, season("Winter"));
            .broadcast(tell, season(Season));
        }
        .wait(1000);
        nextSeason;
        !waitAgents.
