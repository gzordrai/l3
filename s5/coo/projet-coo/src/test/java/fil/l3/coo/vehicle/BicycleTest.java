package fil.l3.coo.vehicle;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * This class test the Bicycle class.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class BicycleTest {

    /**
     * We'll need a Bicycle
     */
    Bicycle b;

    /**
     * Instantiate a Bicycle before any Test.
     */
    @BeforeEach
    public void init(){
        b = new Bicycle();
    }

    /**
     * This test verifies if the Bicycle object is instantiated as expected.
     */
    @Test
    public void isBicycleCreatedCorrectly(){
        assertEquals(b.getName(), "Bicycle");
        assertEquals(b.getOutOfService(), false);
    }

}
