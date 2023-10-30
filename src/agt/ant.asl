// Agent ant

/* Initial beliefs and rules */
~died.
food(0).
season("None").
/* Initial goals */
!init.

/* Plans */
+!init: true
    <-  .print("The ant is born");
        addAgent;
        !next.

+!next: not died & season(Season)
    <-  .send(climate, tell, antIsReady);
        //-season(Season);
        .abolish(season(_));
        .wait(season(NewSeason));
        .print("The new season is ", NewSeason);
        .wait(500);
        .print("The ant is ready");
        .print("The ant is thinking");
        .send(climate, untell, antIsReady);
        if(NewSeason == "Winter") {
            !eatFood; 
        } else {
            !work;
        }.

+!work: not died & food(X)
    <-  .print("The ant is working");
        worked;
        Y = X + 2;
        -food(X);
        +food(Y);
        !next.
        
+!eatFood: not died & food(X)
    <-  .print("The ant food is: ", X);
        if(X > 0) {
            .print("The ant is eating");
            ate;
            Y = X - 1;
            -food(X);
            +food(Y);
            !next;
        } else {
            .print("The ant is dead");
            !death;
        }.

+!startNegotiation[source(Ag)]: not died & food(X) 
    <-  .print("The ant is starting a negotiation with ", Ag);
        if(X > 0) {
            verifyBalance(Balance, Ag);
            if(Balance >= 0) {
                !giveFood(Ag);
            } if(Balance <= -10) {
                .send(Ag, achieve, death);
            } else {
                !askCounterProposal(Ag);
            }
        } else {
            .print("The ant has no food");
            .send(Ag, achieve, death);
        }.

+!askCounterProposal(Ag): not died & food(X) 
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
            //!eatFood;
            .print("The ant is eating superfluous food");
            ate;
            Y = X - 1;
            -food(X);
            +food(Y);
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
