package td_1;

public class ServiceOne extends Service {
    public ServiceOne() {
        super();
    }

    public int cost() {
        return 1;
    }

    public void execute(ServiceUser user) {
        user.decreaseMoney(this.cost());
    }
}
