package fil.l3.coo.vehicle.equipement;

import fil.l3.coo.vehicle.MockTransport;
import fil.l3.coo.vehicle.Vehicle;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * This class test the Foldable class.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class LuggageRackTest extends MockTransport {

    /**
     * We have to use the MockTransport for adding the ability to fold.
     */
    Vehicle t;

    /**
     * Instantiate Transport with a Luggage Rack before any test.
     */
    @BeforeEach
    public void init(){
        t = new MockTransport();
        // Adding the ElectricMotor
        t = new LuggageRack(t);
    }

    /**
     * This test verifies if the Luggage Rack is correctly added to the Transport object.
     */
    @Test
    public void isElectricMotorDecorateCorrectly(){
        assertEquals(t.getName(), "Dummy, have a Luggage Rack");
    }
}
