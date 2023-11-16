package td_1;

public class ServiceTwo extends Service {
    public ServiceTwo() {
        super();
    }

    public int cost() {
        return 2;
    }

    public void execute(ServiceUser user) {
        user.decreaseMoney(this.cost());
    }
}
