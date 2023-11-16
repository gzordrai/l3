package td_1;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class ServiceOneTest extends ServiceTest {
    @Override
    protected Service createService() {
        return new ServiceOne();
    }

    @Test
    public void cost() {
        assertEquals(1, this.service.cost());
    }

}
