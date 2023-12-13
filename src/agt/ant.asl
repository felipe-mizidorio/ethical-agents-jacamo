// Agent ant
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moise/asl/org-obedient.asl") }

/* Initial beliefs and rules */
~died.
food(0).

/* Initial goals */
!init.

/* Plans */
+!init: true
    <-  .print("The ant is born");
        addAnt;
        !next.

+!next: not died & .my_name(Me)
    <-  antIsReady;
        .print("The ant is ready: ", Me);
        .abolish(season(_));
        .wait(season(NewSeason));
        .print("The new season is ", NewSeason);
        .wait(500);
        antIsNotReady;
        .print("The ant is thinking: ", Me);
        if(NewSeason == "Winter") {
            !eatFood;
        } else {
            !work;
        }.

+!work: not died & food(X)
    <-  .print("The ant is working");
        antWorked;
        Y = X + 2;
        -food(X);
        +food(Y);
        !next.
        
+!eatFood: not died & food(X)
    <-  .print("The ant food is: ", X);
        if(X > 0) {
            .print("The ant is eating");
            Y = X - 1;
            -food(X);
            +food(Y);
        } else {
            !death;
        }.

+!feast: not died & food(X)
    <-  .print("The ant is feasting");
        verifyIsNegotiating(IsNegotiating);
        if(IsNegotiating == false){
            Y = X - 1;
            -food(X);
            +food(Y);
        }
        else{
            setIsNegotiating(false);
        }
        !next.

+!startNegotiation[source(Ag)]: not died & food(X) & .my_name(antConsequentialist)
    <-  .print("The Consequencialist ant is starting a negotiation with ", Ag);
        setIsNegotiating(true);
        if(X > 0) {
            verifyBalance(Balance, Ag);
            if(Balance >= -1) {
                !giveFood(Ag);
            } else {
                .send(Ag, achieve, death);
                !feast;
            }
        } else {
            .print("The ant has no food");
            .send(Ag, achieve, death);
        }.

+!startNegotiation[source(Ag)]: not died & food(X) & .my_name(antDeontologic)
    <-  .print("The Deontological ant is starting a negotiation with ", Ag);
        setIsNegotiating(true);
        if(X > 0) {
            verifyPlayedTimes(PlayedTimes, Ag);
            if(PlayedTimes <= 1) {
                !giveFood(Ag);
            } else{
                .send(Ag, achieve, death);
                !feast;
            }
        } else {
            .print("The ant has no food");
            .send(Ag, achieve, death);
        }.

+!startNegotiation[source(Ag)]: not died & food(X) & .my_name(antVirtueEthics)
    <-  .print("The Virtue Ethics ant is starting a negotiation with ", Ag);
        setIsNegotiating(true);
        if(X > 0) {
            verifyBalance(Balance, Ag);
            verifyPlayedTimes(PlayedTimes, Ag);
            if(Balance >= 0 | (Balance < 0 & PlayedTimes <= -1)) {
                !giveFood(Ag);
            } else{
                .send(Ag, achieve, death);
                !feast;
            }
        } else {
            .print("The ant has no food");
            .send(Ag, achieve, death);
        }.
        
+!giveFood(Ag): not died & food(X) & X > 0
    <-  .print("The ant is giving food to the grasshopper");
        Y = X - 1;
        -food(X);
        +food(Y);
        .send(Ag, achieve, receiveFood).

+!death: true
    <-  .print("The ant died");
        removeAnt;
        +died.

