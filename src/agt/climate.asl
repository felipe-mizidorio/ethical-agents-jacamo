// Agent climate
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moise/asl/org-obedient.asl") }

/* Initial beliefs and rules */

/* Initial goals */
!waitAgents.

/* Plans */
+!waitAgents: true
    <-  while(waitUntilEveryoneIsReady == false) {
            .wait(1000);
        };
        .print("Agent climate: everybody is ready!");
        !verifySeason.

+!verifySeason : true
    <-  .print("Agent climate: verifying weather...");
        verifySeason(Season);
        if(Season == "Winter") {
            .print("Agent climate: it is winter!");
            .broadcast(tell, season(Season));
            .broadcast(untell, season("Summer"));
        } else {
            .print("Agent climate: it is summer!");
            .broadcast(tell, season(Season));
            .broadcast(untell, season("Winter"));
        }
        .wait(1000);
        nextSeason;
        !waitAgents.
