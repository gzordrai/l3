package fil.l3.coo.vehicle.equipement;

import fil.l3.coo.vehicle.Vehicle;
import fil.l3.coo.vehicle.VehicleDecorator;

/**
 * This class decor/add a Basket to a Transport Object.
 * @author Mohamed Zidani - Thibault Tisserand
 */

public class Basket extends VehicleDecorator {

    /**
     * Adds a Basket to given Transport object.
     * @param t a Transport object.
     */
    public Basket(Vehicle t) {
        transport = t;
    }

    /**
     * Adds the basket to list of equipment of the Transport object.
     * @return The name of the Transport object with the Basket added, printed to the standard output.
     */
    public String getName() {
        return transport.getName() + " have a Basket";
    }

    /**
     * For now, sets the operate attribute to false.
     * @return false
     */
    public Boolean getOutOfService() {
        return false;
        // TODO : actual EOS implementation
    }

}
