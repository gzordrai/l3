package td_1;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.jupiter.api.BeforeEach;

public abstract class ServiceTest {
    protected final static int MONEY = 100;
    protected Service service;
    protected ServiceUser user;
    protected abstract Service createService();
    // protected abstract void isUsedBy();

    @BeforeEach
    public void init() {
        this.service = this.createService();
        this.user = new ServiceUser(MONEY);
    }

    @Test
    public void getNumberOfUse() {
        assertEquals(0, this.service.getNumberOfUse());
    }

    @Test
    public void cost() {
        assertEquals(0, this.service.cost());
    }

    @Test
    public void isUsedBy() {
        service.isUsedBy(user);

        assertEquals(1, this.service.getNumberOfUse());
        assertEquals(MONEY - this.service.cost(), this.user.getMoney());
    }
}