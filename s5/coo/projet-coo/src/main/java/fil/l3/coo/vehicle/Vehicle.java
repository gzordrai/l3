package fil.l3.coo.vehicle;

/**
 * This abstract class defines the Transport object.
 * @author Mohamed Zidani - Thibault Tisserand
 * */
public abstract class Vehicle {

    /**
     * The name of the Transport.
     */
    private String name;

    /**
     * The status of "Out of Service".
     */
    private Boolean isOutOfService;

    /**
     * Getting the name of the Transport.
     * @return The name of the Transport.
     */
    public String getName() {
        return this.name;
    }

    /**
     * Getting if the Transport is out of service or not.
     * @return If the Transport is out of service or not.
     */
    public Boolean getOutOfService() {
        return this.isOutOfService;
    }

    /**
     * Setting the name of the Transport.
     * @param name The name of the Transport.
     */
    public void setName(String name){
        this.name = name;
    }

    /**
     * Setting the "Out of Service" status of the Transport.
     * @param outOfService "true" if the Transport is Out of Service, "false" otherwise.
     */
    public void setOutOfService(Boolean outOfService) {
        this.isOutOfService = outOfService;
    }

    /**
     * Prints in the standard output the name of the Transport, and if it is Out of Service.
     * @return A String containing the name of the Transport and the Out of Service Status.
     */
    public String toString() {
        return getName() + " | Is out of service : " + getOutOfService().toString();
    }
}
