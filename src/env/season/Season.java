package season;

import cartago.*;

public class Season extends Artifact {
    private String season;

    void init() {
        this.season = "Summer";
        defineObsProperty("season", season);
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
