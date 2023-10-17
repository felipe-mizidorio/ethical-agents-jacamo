// Agent ant

/* Initial beliefs and rules */

/* Initial goals */
!verifyWeather.

/* Plans */
+!work(IsWinter): not IsWinter
    <-  .print("The ant is working");
        add;
        .print("added");
        !verifyWeather.
        
+!eatFood(IsWinter): IsWinter 
    <-  .print("The ant is eating");
        remove;
        .print("removed");
        !verifyWeather.

+!verifyWeather: true 
    <-  .print("The ant is verifying the weather");
        verifyWinter(IsWinter);
        verifyFood(FoodAmount);
        .print("Is winter: ", IsWinter);
        .print("Amount Food: ", FoodAmount);
        if(IsWinter) {
            if(FoodAmount > 0) {
                !eatFood(IsWinter);
            } else {
                !death;
            }
        } else {
            !work(IsWinter);
        }.

+!death: true
    <-  .print("The ant died").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }