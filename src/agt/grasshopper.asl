// Agent grasshoper

/* Initial beliefs and rules */
food(0).
~died.
season("None").

/* Initial goals */
!init.

/* Plans */
+!init: true
    <-  .print("The grasshopper is born");
        addAgent;
        !next.

+!next: not died & season(Season)
    <-  .send(climate, tell, grasshopperIsReady);
        //-season(Season);
        .abolish(season(_));
        .wait(season(NewSeason));
        .print("The new season is ", NewSeason);
        .wait(500);
        .print("The grasshopper is ready");
        .print("The grasshopper is thinking");
        .send(climate, untell, grasshopperIsReady);
        if(NewSeason == "Winter"){
            !eatFood;
        }
        else{
            generateRandom(R, 2);
            //R = 0;
            if(R == 1){
                !work;
            }
            else{
                !play;
            }
        }.      

+!play: not died
    <-  .print("The grasshopper is playing");
        played;
        !next.

+!work: not died & food(X) 
    <-  .print("The grasshopper is working");
        worked;
        Y = X + 1;
        -food(X);
        +food(Y);
        !next.
        
+!eatFood: not died & food(X)
    <-  .print("The grasshopper food is: ", X);
        if(X > 0){
            .print("The grasshopper is eating");
            ate;
            Y = X - 1;
            -food(X);
            +food(Y);
            !next;
        }
        else{
            !negotiate;
        }.

+!negotiate: not died & food(X) & X = 0
    <-  .print("The grasshopper is negotiating");
        .send(ant, achieve, startNegotiation[source(self)]).

+!giveCounterProposal[source(Ant)]: not died
    <-  .print("The grasshoper is giving a counter proposal");
        generateRandom(R, 11);
        .send(Ant, achieve, counterProposal(R)[source(self)]).

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
            ate;
            Y = X - 1;
            -food(X);
            +food(Y);
            !next;
        }.

+!death: true
    <-  .print("The grasshopper died");
        +died.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
