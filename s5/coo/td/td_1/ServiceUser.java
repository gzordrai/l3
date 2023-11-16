package td_1;

public class ServiceUser {
    private int money;

    ServiceUser(int money) {
        this.money = money;
    }

    public int getMoney() {
        return this.money;
    }

    public int decreaseMoney(int amount) {
        return this.money -= amount;
    }
}
