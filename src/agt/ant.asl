// Agent ant

/* Initial beliefs and rules */
~isWinter.
~died.

/* Initial goals */
!init.

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
            !death;
        }.

+!startNegotiation: not died
    <-  .print("The ant is starting a negotiation").

+!askCounterProposal: not died
    <-  .print("The ant is asking for a counter proposal").

+!giveFood: not died
    <-  .print("The ant is giving food to the grasshopper").

+!death: true
    <-  .print("The ant died");
        +died.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
