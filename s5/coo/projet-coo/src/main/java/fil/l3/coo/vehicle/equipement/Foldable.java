package fil.l3.coo.vehicle.equipement;

import fil.l3.coo.vehicle.Vehicle;
import fil.l3.coo.vehicle.VehicleDecorator;


/**
 * This class decor/add the Foldable attribute to a Transport Object.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class Foldable extends VehicleDecorator {

    /**
     * Adds the Foldable attribute to given Transport object.
     * @param t a Transport object.
     */
    public Foldable(Vehicle t){
        transport = t;
    }

    /**
     * Adds the Foldable attribute to list of equipment of the Transport object.
     * @return The name of the Transport object with the Foldable attribute added, printed to the standard output.
     */
    public String getName() {
        return transport.getName() + ", is foldable";
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
