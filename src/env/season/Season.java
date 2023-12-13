package season;

import cartago.*;

public class Season extends Artifact {
    private String season;
    private Integer seasonCounter = 0;

    void init() {
        this.season = "Summer";
        defineObsProperty("season", season);
    }

    @OPERATION
    void seasonIncrement() {
        this.seasonCounter = this.seasonCounter + 1;
        System.out.println("Season Counter: " + this.seasonCounter);
    }

    @OPERATION
    void verifySeasonCounter(OpFeedbackParam<Integer> X) {
        X.set(this.seasonCounter);
    }
    @OPERATION
    void nextSeason() {
        this.season = this.season.equals("Summer") ? "Winter" : "Summer";
        getObsProperty("season").updateValue(this.season);
    }

    @OPERATION
    void verifySeason(OpFeedbackParam<String> X) {
        getObsProperty("season").updateValue(this.season);
        X.set(this.season);
    }
}
