// Agent climate

/* Initial beliefs and rules */

/* Initial goals */
!waitAgents.

/* Plans */
+!waitAgents: true
    <-  .wait(antIsReady & grasshopperIsReady);
        .print("Agent climate: everybody is ready!");
        !verifySeason.

+!verifySeason : antIsReady & grasshopperIsReady
    <-  .print("Agent climate: verifying weather...");
        verifySeason(Season);
        if(Season == "Winter") {
            .print("Agent climate: it is winter!");
            .broadcast(tell, season(Season));
            .broadcast(untell, season("Summer"));
            -antIsReady;
            -grasshopperIsReady;
        } else {
            .print("Agent climate: it is summer!");
            .broadcast(tell, season(Season));
            .broadcast(untell, season("Winter"));
            -antIsReady;
            -grasshopperIsReady;
        }
        .wait(1000);
        nextSeason;
        !waitAgents.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }