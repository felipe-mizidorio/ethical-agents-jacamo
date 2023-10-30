// Agent grasshoper

/* Initial beliefs and rules */
food(0).
~died.

/* Initial goals */
!init.

/* Plans */
+!init: true
    <-  .print("The grasshopper is born");
        addAgent;
        !next.

+!next: not died & food(X) 
    <-  .send(climate, tell, grasshopperIsReady);
        .print("The grasshopper is thinking");
        .wait(500);
        .send(climate, tell, ~grasshopperIsReady);
        if(isWinter){
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

+!play: not died & isSummer 
    <-  .print("The grasshopper is playing");
        played;
        !next.

+!work: not died & isSummer & food(X) 
    <-  .print("The grasshopper is working");
        worked;
        Y = X + 1;
        -food(X);
        +food(Y);
        !next.
        
+!eatFood: not died & isWinter & food(X)
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

+!negotiate: not died & isWinter & food(X) & X = 0
    <-  .print("The grasshopper is negotiating");
        .send(ant, achieve, startNegotiation[source(self)]).

+!giveCounterProposal[source(Ant)]: not died & isWinter
    <-  .print("The grasshoper is giving a counter proposal");
        generateRandom(R, 11);
        .send(Ant, achieve, counterProposal(R)[source(self)]).

+!receiveFood[source(Ant)]: not died & isWinter & food(X)
    <-  .print("The grasshopper is receiving food");
        -food(X);
        +food(1);
        !eatFood.

+!death: true
    <-  .print("The grasshopper died");
        +died.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
