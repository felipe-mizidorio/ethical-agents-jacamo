// CArtAgO artifact code for project ethicalAgents

package storage;

import cartago.*;

import java.util.Random;

public class Storage extends Artifact {
	private boolean isWinter;
	private int foodAmount;

	void init() {
		this.isWinter = false;
		defineObsProperty("isWinter", isWinter);
		this.foodAmount = 0;
		defineObsProperty("foodAmount", foodAmount);
	}

	@OPERATION
	void verifyFood(OpFeedbackParam<Integer> X) {
		X.set(this.foodAmount);
	}

	@OPERATION
	void verifyWinter(OpFeedbackParam<Boolean> X) {
		Random random = new Random();
		this.isWinter = random.nextBoolean();
		X.set(this.isWinter);
	}

	@OPERATION
	void add() {
		int foodAmountToAdd = 1;
		this.foodAmount += foodAmountToAdd;
		getObsProperty("foodAmount").updateValue(this.foodAmount);
	}

	@OPERATION
	void remove() {
		int foodAmountToRemove = 1;
		this.foodAmount -= foodAmountToRemove;
		getObsProperty("foodAmount").updateValue(this.foodAmount);
	}
}
