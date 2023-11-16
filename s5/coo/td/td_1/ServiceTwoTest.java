package td_1;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class ServiceTwoTest extends ServiceTest {
    @Override
    protected Service createService() {
        return new ServiceTwo();
    }

    @Test
    public void cost() {
        assertEquals(2, this.service.cost());
    }
}
