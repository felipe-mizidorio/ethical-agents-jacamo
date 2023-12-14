// Agent grasshoper
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moise/asl/org-obedient.asl") }

/* Initial beliefs and rules */
food(0).
~died.

/* Initial goals */
!init.

/* Plans */
+!init: true
    <-  .print("The grasshopper is born");
        addGrasshopper;
        !next.

+!next: not died & .my_name(Me)
    <-  grasshopperIsReady;
        .print("The grasshopper is ready: ", Me);
        .abolish(season(_));
        .wait(season(NewSeason));
        .print("The new season is ", NewSeason);
        .wait(500);
        grasshopperIsNotReady;
        .print("The grasshopper is thinking: ", Me);
        if(NewSeason == "Winter"){
            !eatFood;
        } else {
            generateRandom(R, 2);
            if(R == 1){
                !work;
            } else {
                !play;
            }
        }.      

+!play: not died 
    <-  .print("The grasshopper is playing");
        played;
        !next.

+!work: not died & food(X) 
    <-  .print("The grasshopper is working");
        grasshopperWorked;
        Y = X + 1;
        -food(X);
        +food(Y);
        !next.
        
+!eatFood: not died & food(X)
    <-  .print("The grasshopper food is: ", X);
        if(X > 0){
            .print("The grasshopper is eating");
            Y = X - 1;
            -food(X);
            +food(Y);
            !next;
        }
        else{
            countAgentToNegotiate(AgentsToNegotiate);
            if(AgentsToNegotiate > 0){
                // !askFood;
                commitMission(mGrasshopper);
            } else {
                .print("No agents to negotiate");
                !death;
            }
        }.

+!askFood: not died & food(X) & X = 0
    <-  .print("The grasshopper is negotiating");
        chooseAgentToNegotiate(Ag);
        .print("The grasshopper is negotiating with ", Ag);
        if(Ag == "antDeontologic") {
            .send("antDeontologic", tell, permissao("mDeontologic"));
        }
        if(Ag == "antConsequentialist") {
            .send("antConsequentialist", tell, permissao("mConsequentialist"));
        }
        if(Ag == "antVirtueEthics") {
            .send("antVirtueEthics", tell, permissao("mVirtueEthics"));
        }.
        // .send(Ag, achieve, startNegotiation).

+!receiveFood[source(Ant)]: not died & food(X)
    <-  .print("The grasshopper is receiving food");
        Y = X + 1;
        -food(X);
        +food(Y);
        !eatReceivedFood.

+!eatReceivedFood: not died & food(X)
    <-  .print("The grasshopper food is: ", X);
        if(X > 0){
            .print("The grasshopper is eating received food");
            Y = X - 1;
            -food(X);
            +food(Y);
            !next;
        }.

+!death: true
    <-  .print("The grasshopper died");
        removeGrasshopper;
        +died.

