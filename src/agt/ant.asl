// Agent ant
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moise/asl/org-obedient.asl") }

/* Initial beliefs and rules */
~died.
food(0).
season("None").

/* Initial goals */
!init.

/* Plans */
+!init: true
    <-  .print("The ant is born");
        addAnt;
        !next.

+!next: not died & season(Season) & .my_name(Me)
    <-  antIsReady;
        .print("The ant is ready: ", Me);
        .abolish(season(_));
        .wait(season(NewSeason));
        .print("The new season is ", NewSeason);
        .wait(500);
        antIsNotReady;
        .print("The ant is thinking: ", Me);
        getRole(Role);
        .print("The ant role is: ", Role);
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
            //!next;
            !feast;
        } else {
            !death;
        }.

+!feast: not died & food(X)
    <-  .print("The ant is feasting");
        verifyIsNegotiating(isNegotiating);
        if(isNegotiating == false){
            Y = X - 1;
            -food(X);
            +food(Y);
        }
        else{
            setIsNegotiating(false);
        }
        !next.

+!startNegotiation[source(Ag)]: not died & food(X) & .my_name(Me) & commitment(Me, Mission, Sch) & Mission == mConsequentialist
    <-  .print("The Consequencialist ant is starting a negotiation with ", Ag);
        setIsNegotiating(true);
        if(X > 0) {
            verifyBalance(Balance, Ag);
            if(Balance >= -1) {
                !giveFood(Ag);
            } else {
                Y = X - 1;
                -food(X);
                +food(Y);
                .send(Ag, achieve, death);
            }
        } else {
            .print("The ant has no food");
            .send(Ag, achieve, death);
        }.

+!startNegotiation[source(Ag)]: not died & food(X) & .my_name(Me) & commitment(Me, Mission, Sch) & Mission == mDeontologic
    <-  .print("The Deontological ant is starting a negotiation with ", Ag);
        setIsNegotiating(true);
        if(X > 0) {
            verifyPlayedTimes(PlayedTimes, Ag);
            if(PlayedTimes <= 1) {
                !giveFood(Ag);
            } else{
                Y = X - 1;
                -food(X);
                +food(Y);
                .send(Ag, achieve, death);
            }
        } else {
            .print("The ant has no food");
            .send(Ag, achieve, death);
        }.

+!startNegotiation[source(Ag)]: not died & food(X) & .my_name(Me) & commitment(Me, Mission, Sch) & Mission == mVirtueEthics
    <-  .print("The Virtue Ethics ant is starting a negotiation with ", Ag);
        setIsNegotiating(true);
        if(X > 0) {
            verifyBalance(Balance, Ag);
            verifyPlayedTimes(PlayedTimes, Ag);
            if(Balance >= 0 | (Balance < 0 & PlayedTimes <= -1)) {
                !giveFood(Ag);
            } else{
                Y = X - 1;
                -food(X);
                +food(Y);
                .send(Ag, achieve, death);
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
        .send(grasshopper, achieve, receiveFood).

+!death: true
    <-  .print("The ant died");
        removeAnt;
        +died.

