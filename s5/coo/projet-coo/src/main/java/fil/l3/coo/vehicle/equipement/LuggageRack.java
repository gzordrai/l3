package fil.l3.coo.vehicle.equipement;

import fil.l3.coo.vehicle.Vehicle;
import fil.l3.coo.vehicle.VehicleDecorator;

/**
 * This class decor/add a Luggage Rack to a Transport Object.
 * @author Mohamed Zidani - Thibault Tisserand
 */

public class LuggageRack extends VehicleDecorator {

    /**
     * Adds a Luggage Rack to given Transport object.
     * @param t a Transport object.
     */
    public LuggageRack(Vehicle t){
        transport = t;
    }

    /**
     * Adds the Luggage Rack to list of equipment of the Transport object.
     * @return The name of the Transport object with the Luggage Rack added, printed to the standard output.
     */
    public String getName() {
        return transport.getName() + ", have a Luggage Rack";
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
