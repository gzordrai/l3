package fil.l3.coo.vehicle;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertSame;

/**
 * This class test the Transport class.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class TransportTest {

    /**
     *  We're using a Mock instance for testing the Transport abstract class.
     */
    MockTransport mt;

    /**
     * This method instantiate a MockTransport object before any test.
     */
    @BeforeEach
    public void init(){
         mt = new MockTransport();
    }

    /**
     * This test verifies if the Transport object is instantiated as expected.
     */
    @Test
    public void isTransportCreatedCorrectly(){
        assertSame(mt.getName(), "Dummy");
        assertSame(mt.getOutOfService(), false);
    }

}
