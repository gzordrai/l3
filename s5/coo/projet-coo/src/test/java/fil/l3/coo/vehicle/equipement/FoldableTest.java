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
public class FoldableTest extends MockTransport {

    /**
     * We have to use the MockTransport for adding the ability to fold.
     */
    Vehicle t;

    /**
     * Instantiate Foldable Transport before any test.
     */
    @BeforeEach
    public void init(){
        t = new MockTransport();
        // Adding the ElectricMotor
        t = new Foldable(t);
    }

    /**
     * This test verifies if the Foldable aspect is correctly added to the Transport object.
     */
    @Test
    public void isElectricMotorDecorateCorrectly(){
        assertEquals(t.getName(), "Dummy, is foldable");
    }
}
