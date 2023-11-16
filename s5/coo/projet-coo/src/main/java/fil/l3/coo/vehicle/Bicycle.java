package fil.l3.coo.vehicle;

/**
 *
 * This class defines the Bicycle object.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class Bicycle extends Vehicle {

    /**
     * A Bicycle is simply a Transport object with the name "Bicycle" added.
     */
    public Bicycle() {
        setName("Bicycle");
        setOutOfService(false);
    }
}
