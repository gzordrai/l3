package fil.l3.coo.vehicle.equipement;

import fil.l3.coo.vehicle.Vehicle;
import fil.l3.coo.vehicle.VehicleDecorator;

/**
 * This class decor/add an Electric Motor to a Transport Object.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class ElectricMotor extends VehicleDecorator {

    /**
     * Adds an Electric Motor to given Transport object.
     * @param t a Transport object.
     */
    public ElectricMotor(Vehicle t){
        transport = t;
    }

    /**
     * Adds the Electric Motor to list of equipment of the Transport object.
     * @return The name of the Transport object with the Electric Motor added, printed to the standard output.
     */
    public String getName() {
        return transport.getName() + ", is Electric";
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
