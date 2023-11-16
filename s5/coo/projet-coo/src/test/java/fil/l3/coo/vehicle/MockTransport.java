package fil.l3.coo.vehicle;

/***
 * This class creates a dummy Transport instance.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class MockTransport extends Vehicle {

    /**
     * This Mock is just a Transport object, that can operate.
     */
    public MockTransport(){
        super.setName("Dummy");
        super.setOutOfService(false);
    }
}
