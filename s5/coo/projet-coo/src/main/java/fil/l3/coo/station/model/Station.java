package fil.l3.coo.station.model;

import fil.l3.coo.station.exceptions.StationFullCapacityException;
import fil.l3.coo.station.observer.Subject;
import fil.l3.coo.vehicle.Vehicle;

public class Station extends Subject {
    public static final int MIN_CAPACITY = 10;
    public static final int MAX_CAPACITY = 20;

    public static int nextId = 1;

    private final int ID;
    private final int CAPACITY;

    private final Vehicle[] vehicles;

    public Station() {
        super();

        this.ID = Station.nextId++;
        this.CAPACITY = (int) (Math.random() * (Station.MAX_CAPACITY - Station.MIN_CAPACITY)) + Station.MIN_CAPACITY;
        this.vehicles = new Vehicle[this.CAPACITY];
    }

    /**
     * Returns the ID of the station.
     *
     * @return the ID of the station
     */
    public int getId() {
        return this.ID;
    }

    /**
     * Returns the capacity of the station.
     *
     * @return the capacity of the station
     */
    public int getCapacity() {
        return this.CAPACITY;
    }

    /**
     * Returns an array of bikes in the station.
     *
     * @return an array of bikes in the station
     */
    public Vehicle[] getVehicles() {
        return this.vehicles;
    }

    /**
     * Returns the number of vehicles currently in the station.
     *
     * @return the number of vehicles currently in the station
     */
    public int getVehicleCount() {
        int size = 0;

        for (Vehicle vehicle : this.vehicles) {
            if (vehicle != null)
                size++;
        }

        return size;
    }

    /**
     * Returns true if the station is full, false otherwise.
     *
     * @return true if the station is full, false otherwise
     */
    public boolean isFull() {
        return this.getVehicleCount() == this.CAPACITY;
    }

    /**
     * Adds a vehicle to the station.
     *
     * @param vehicle the vehicle to add to the station
     * @throws StationFullCapacityException if the station is full and cannot accept any more bikes
     */
    public void addVehicle(Vehicle vehicle) throws StationFullCapacityException {
        if (this.isFull())
            throw new StationFullCapacityException();

        for (int i = 0; i < this.vehicles.length; i++) {
            if (this.vehicles[i] == null) {
                this.vehicles[i] = vehicle;
                break;
            }
        }

        this.notifyObservers();
    }
}
