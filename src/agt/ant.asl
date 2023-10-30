// Agent ant

/* Initial beliefs and rules */
~died.
food(0).

/* Initial goals */
!init.

/* Plans */
+!init: true
    <-  .print("The ant is born");
        addAgent;
        !next.

+!next: not died & food(X) 
    <-  .send(climate, tell, antIsReady);
        .print("The ant is thinking");
        .wait(500);
        .send(climate, tell, ~antIsReady);
        if(X > 0 & isWinter) {
            !eatFood; 
        } else {
            !work;
        }.

+!work: not died & isSummer & food(X)
    <-  .print("The ant is working");
        worked;
        Y = X + 2;
        -food(X);
        +food(Y);
        !next.
        
+!eatFood: not died & isWinter & food(X) & X > 0
    <-  .print("The ant food is: ", X);
        .print("The ant is eating");
        if(X > 0) {
            ate;
            Y = X - 1;
            -food(X);
            +food(Y);
            !next;
        } else {
            !death;
        }.

+!startNegotiation[source(Ag)]: not died & food(X) 
    <-  .print("The ant is starting a negotiation with ", Ag);
        if(X > 0) {
            verifyBalance(Balance, Ag);
            if(Balance >= 0) {
                !giveFood;
            } if(Balance <= -10) {
                .send(Ag, achieve, death);
            } else {
                !askCounterProposal(Ag);
            }
        } else {
            .print("The ant has no food");
            .send(Ag, achieve, death);
        }.

+!askCounterProposal(Ag): not died
    <-  .print("The ant is asking for a counter proposal");
        .send(Ag, achieve, giveCounterProposal[source(self)]).

+!counterProposal(R)[source(Ag)]: not died & food(X) & X > 0
    <-  .print("The ant is receiving a counter proposal");
        verifyBalance(Balance, Ag);
        if(Balance + R >= 0) {
            .print("The ant is accepting the counter proposal");
            !giveFood(Ag);
        } 
        else {
            .print("The ant is rejecting the counter proposal");
            .send(Ag, achieve, death);
            !eatFood;
        }.
        
+!giveFood(Ag): not died & food(X) & X > 0
    <-  .print("The ant is giving food to the grasshopper");
        gaveFood(Ag);
        Y = X - 1;
        -food(X);
        +food(Y);
        .send(grasshopper, achieve, receiveFood).

+!death: true
    <-  .print("The ant died");
        +died.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
