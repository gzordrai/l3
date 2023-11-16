package fil.l3.coo.vehicle;

/**
 * This class decorates (or "add") a Transport object with given equipment.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public abstract class VehicleDecorator extends Vehicle {

    /**
     * The Transport object to decorate.
     */
    protected Vehicle transport;

    /**
     * This abstract method will override the original Transport 'getName()' method
     * and will be redefined by the equipment.
     * @return A String added by the equipment and printed to the standard output.
     */
    public abstract String getName();
    public abstract Boolean getOutOfService();

}
