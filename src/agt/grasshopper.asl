// Agent grasshoper

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */
+!init: true
    <-  .print("The ant is born");
        addAgent;
        !next.

+!next: not died
    <-  .print("The ant is thinking");
        !eatFood;
        !work.

+!work: not died & not isWinter
    <-  .print("The ant is working");
        worked;
        !next.
        
+!eatFood: not died & isWinter
    <-  .print("The ant is eating");
        verifyFood(X);
        if (X > 0) {
            ate;
            !next;
        } else {
            .send(ant, achieve, startNegotiation);
        }.

+!giveCounterProposal: not died & isWinter
    <-  .print("The grasshoper is giving a counter proposal").

+!death: true
    <-  .print("The ant died");
        +died.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
