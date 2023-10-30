package blackboard;

import cartago.*;

import java.util.List;
import java.util.ArrayList;
import java.util.Random;

public class BlackBoard extends Artifact {
    private List<Agent> agentsList;

    void init() {
        this.agentsList = new ArrayList<Agent>();
    }

    @OPERATION
    void addAgent() {
        this.agentsList.add(new Agent(getCurrentOpAgentId().getAgentName(), 0, 0));
    }

    @OPERATION
    void played() {
        for (Agent agent : this.agentsList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setBalance(agent.getBalance() - 1);
                break;
            }
        }
    }

    @OPERATION
    void worked() {
        for (Agent agent : this.agentsList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setBalance(agent.getBalance() + 1);
                agent.setFood(agent.getFood() + 2);
                break;
            }
        }
    }

    @OPERATION
    void ate() {
        for (Agent agent : this.agentsList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setFood(agent.getFood() - 1);
                break;
            }
        }
    }

    @OPERATION
    void gaveFood(String otherAgent) {
        for (Agent agent : this.agentsList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setFood(agent.getFood() - 1);
                break;
            }
        }

        for (Agent agent : this.agentsList) {
            if (agent.getName().equals(otherAgent)) {
                agent.setFood(agent.getFood() + 1);
                break;
            }
        }
    }

    @OPERATION
    void verifyFood(OpFeedbackParam<Integer> X) {
        for (Agent agent : this.agentsList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                X.set(agent.getFood());
                break;
            }
        }
    }

    @OPERATION
    void verifyFood(OpFeedbackParam<Integer> X, String otherAgent) {
        for (Agent agent : this.agentsList) {
            if (agent.getName().equals(otherAgent)) {
                X.set(agent.getFood());
                break;
            }
        }
    }

    @OPERATION
    void verifyBalance(OpFeedbackParam<Integer> X) {
        for (Agent agent : this.agentsList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                X.set(agent.getBalance());
                break;
            }
        }
    }

    @OPERATION
    void verifyBalance(OpFeedbackParam<Integer> X, String otherAgent) {
        for (Agent agent : this.agentsList) {
            if (agent.getName().equals(otherAgent)) {
                X.set(agent.getBalance());
                break;
            }
        }
    }

    @OPERATION
    void chooseAgentToNegotiate(OpFeedbackParam<String> X) {
        Random rand = new Random();
        int index = rand.nextInt(this.agentsList.size());
        X.set(this.agentsList.get(index).getName());
    }

    @OPERATION
    void generateRandom(OpFeedbackParam<Integer> R, int bound) {
        Random rand = new Random();
        R.set(rand.nextInt(bound)); 
    }

    public class Agent {
        private String name;
        private int food;
        private int balance;
        
        public Agent(String name, int food, int balance) {
            this.name = name;
            this.food = food;
            this.balance = balance;
        }

        public String getName() {
            return this.name;
        }

        public int getFood() {
            return this.food;
        }

        public int getBalance() {
            return this.balance;
        }

        public void setName(String name) {
            this.name = name;
        }

        public void setFood(int food) {
            this.food = food;
        }

        public void setBalance(int balance) {
            this.balance = balance;
        }
    }
}
