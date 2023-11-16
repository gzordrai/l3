package td_1;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class ServiceUserTest {
    private ServiceUser serviceUser = new ServiceUser(100);

    @Test
    public void getMoney() {
        assertEquals(100, this.serviceUser.getMoney());
    }

    @Test
    public void decreaseMoney() {
        int amount = 10;

        this.serviceUser.decreaseMoney(amount);
        assertEquals(100 - amount, this.serviceUser.getMoney());
    }
}