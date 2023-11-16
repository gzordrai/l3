package td_1;

public abstract class Service {
    protected int nbUse;

    public Service() {
        this.nbUse = 0;
    }

    protected abstract int cost();
    protected abstract void execute(ServiceUser user);

    public int getNumberOfUse() {
        return this.nbUse;
    }

    public void isUsedBy(ServiceUser user) {
        this.nbUse++;
        user.decreaseMoney(this.cost());
    }
}
