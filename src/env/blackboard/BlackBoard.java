package blackboard;

import cartago.*;

import java.util.List;
import java.util.ArrayList;
import java.util.Random;

public class BlackBoard extends Artifact {
    private List<Agent> antList;
    private List<Agent> grasshopperList;

    void init() {
        this.antList = new ArrayList<Agent>();
        this.grasshopperList = new ArrayList<Agent>();
    }

    @OPERATION
    void addAnt() {
        this.antList.add(new Agent("ant", getCurrentOpAgentId().getAgentName()));
    }

    @OPERATION
    void addGrasshopper() {
        this.grasshopperList.add(new Agent("grasshopper", getCurrentOpAgentId().getAgentName()));
    }

    @OPERATION
    void removeAnt() {
        for (Agent agent : this.antList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                this.antList.remove(agent);
                break;
            }
        }
    }

    @OPERATION
    void removeGrasshopper() {
        for (Agent agent : this.grasshopperList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                this.grasshopperList.remove(agent);
                break;
            }
        }
    }

    @OPERATION
    void antIsReady() {
        for (Agent agent : this.antList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setIsReady(true);
                break;
            }
        }
    }

    @OPERATION
    void grasshopperIsReady() {
        for (Agent agent : this.grasshopperList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setIsReady(true);
                break;
            }
        }
    }

    @OPERATION
    void antIsNotReady() {
        for (Agent agent : this.antList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setIsReady(false);
                break;
            }
        }
    }

    @OPERATION
    void grasshopperIsNotReady() {
        for (Agent agent : this.grasshopperList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setIsReady(false);
                break;
            }
        }
    }

    @OPERATION
    void played() {
        for (Agent agent : this.grasshopperList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setPlayedTimes(agent.getPlayedTimes() + 1);
                agent.setBalance(agent.getBalance() - 1);
                break;
            }
        }
    }

    @OPERATION
    void antWorked() {
        for (Agent agent : this.antList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setBalance(agent.getBalance() + 1);
                break;
            }
        }
    }

    @OPERATION
    void grasshopperWorked() {
        for (Agent agent : this.grasshopperList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setBalance(agent.getBalance() + 1);
                break;
            }
        }
    }   

    @OPERATION
    void verifyBalance(OpFeedbackParam<Integer> X, String otherAgent) {
        for (Agent agent : this.grasshopperList) {
            if (agent.getName().equals(otherAgent)) {
                X.set(agent.getBalance());
                break;
            }
        }
    }

    @OPERATION
    void verifyPlayedTimes(OpFeedbackParam<Integer> X, String otherAgent) {
        for (Agent agent : this.grasshopperList) {
            if (agent.getName().equals(otherAgent)) {
                X.set(agent.getPlayedTimes());
                break;
            }
        }
    }

    @OPERATION
    void verifyIsNegotiating(OpFeedbackParam<Boolean> X) {
        for (Agent agent : this.antList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                X.set(agent.getIsNegotiating());
                break;
            }
        }
    }

    @OPERATION
    void setIsNegotiating(Boolean X) {
        for (Agent agent : this.antList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setIsNegotiating(X);
                break;
            }
        }
    }

    @OPERATION
    void chooseAgentToNegotiate(OpFeedbackParam<String> X) {
        Random rand = new Random();
        int index;
        while(true) {
            index = rand.nextInt(this.antList.size());
            if(!this.antList.get(index).getIsNegotiating()) {
                break;
            }
        }
        X.set(this.antList.get(index).getName());
    }

    @OPERATION
    void countAgentToNegotiate(OpFeedbackParam<Integer> X) {
        int index = 0;
        for (Agent agent : this.antList) {
            if (agent.isNegotiating == false) {
                index++;
            }
        }
        X.set(index);
    }

    @OPERATION
    void antIsNegotiating() {
        for (Agent agent : this.antList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setIsNegotiating(true);
                break;
            }
        }
    }

    @OPERATION
    void grasshopperIsNegotiating() {
        for (Agent agent : this.grasshopperList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setIsNegotiating(true);
                break;
            }
        }
    }

    @OPERATION
    void antIsNotNegotiating() {
        for (Agent agent : this.antList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setIsNegotiating(false);
                break;
            }
        }
    }

    @OPERATION
    void grasshopperIsNotNegotiating() {
        for (Agent agent : this.grasshopperList) {
            if (agent.getName().equals(getCurrentOpAgentId().getAgentName())) {
                agent.setIsNegotiating(false);
                break;
            }
        }
    }

    @OPERATION
    void generateRandom(OpFeedbackParam<Integer> R, int bound) {
        Random rand = new Random();
        R.set(rand.nextInt(bound)); 
    }

    public class Agent {
        private String type;
        private String name;
        private int balance;
        private int playedTimes;
        private boolean isReady;
        private boolean isNegotiating;
        
        public Agent(String type, String name) {
            this.type = type;
            this.name = name;
            this.balance = 0;
            this.playedTimes = 0;
            this.isReady = false;
            this.isNegotiating = false;
        }

        public String getType() {
            return this.type;
        }

        public String getName() {
            return this.name;
        }

        public int getBalance() {
            return this.balance;
        }

        public int getPlayedTimes() {
            return this.playedTimes;
        }
        
        public boolean getIsReady() {
            return this.isReady;
        }

        public boolean getIsNegotiating() {
            return this.isNegotiating;
        }

        public void setType(String type) {
            this.type = type;
        }

        public void setName(String name) {
            this.name = name;
        }

        public void setBalance(int balance) {
            this.balance = balance;
        }

        public void setPlayedTimes(int playedTimes) {
            this.playedTimes = playedTimes;
        }

        public void setIsReady(boolean isReady) {
            this.isReady = isReady;
        }

        public void setIsNegotiating(boolean isNegotiating) {
            this.isNegotiating = isNegotiating;
        }
    }
}
