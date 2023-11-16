package fil.l3.coo.vehicle.equipement;

import fil.l3.coo.vehicle.MockTransport;
import fil.l3.coo.vehicle.Vehicle;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * This class test the Basket equipment class.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class BasketTest extends MockTransport {

    /**
     * We have to use the MockTransport for adding a Basket to it
     */
    Vehicle t;

    /**
     * Instantiate a Transport object with a Basket before any test.
     */
    @BeforeEach
    public void init(){
        t = new MockTransport();
        // Adding the Basket
        t = new Basket(t);
    }

    /**
     * This test verifies if the Basket is correctly added to the Transport object.
     */
    @Test
    public void isBasketDecorateCorrectly(){
        assertEquals(t.getName(), "Dummy have a Basket");
    }
}
