package fil.l3.coo.vehicle.equipement;

import fil.l3.coo.vehicle.MockTransport;
import fil.l3.coo.vehicle.Vehicle;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * This class test the ElectricMotor equipment class.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class ElectricMotorTest extends MockTransport {

    /**
     * We have to use the MockTransport for adding an ElectricMotor to it
     */
    Vehicle t;

    /**
     * Instantiate an Electric Motor before any test.
     */
    @BeforeEach
    public void init(){
        t = new MockTransport();
        // Adding the ElectricMotor
        t = new ElectricMotor(t);
    }

    /**
     * This test verifies if the Electric Motor is correctly added to the Transport object.
     */
    @Test
    public void isElectricMotorDecorateCorrectly(){
        assertEquals(t.getName(), "Dummy, is Electric");
    }
}
