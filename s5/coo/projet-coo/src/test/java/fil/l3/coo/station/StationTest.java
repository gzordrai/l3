package fil.l3.coo.station;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import fil.l3.coo.station.exceptions.StationFullCapacityException;
import fil.l3.coo.station.model.Station;
import fil.l3.coo.vehicle.Bicycle;
import fil.l3.coo.vehicle.Vehicle;

public class StationTest {
    private Station station;

    @BeforeEach
    public void init() {
        this.station = new Station();
    }

    @Test
    public void testStationId() {
        int id = this.station.getId();

        assertEquals(Station.nextId - 1, id);
    }

    @Test
    public void testStationCapacity() {
        int capacity = this.station.getCapacity();

        assertTrue(capacity >= Station.MIN_CAPACITY && capacity <= Station.MAX_CAPACITY);
    }

    // Useful given the test above ?
    @Test
    public void testStationvehicles() {
        int capacity = this.station.getCapacity();
        int vehicles = this.station.getVehicles().length;

        assertEquals(capacity, vehicles);
    }

    @Test
    public void testAddVehicle() throws StationFullCapacityException {
        Vehicle bike = new Bicycle();

        this.station.addVehicle(bike);

        assertEquals(1, this.station.getVehicleCount());
    }

    @Test
    public void testAddVehicleWhenStationIsFull() throws StationFullCapacityException {
        for (int i = 0; i < this.station.getCapacity(); i++) {
            this.station.addVehicle(new Bicycle());
        }

        Exception exception = assertThrows(StationFullCapacityException.class, () -> this.station.addVehicle(new Bicycle()));

        assertEquals(exception.getMessage(), "Cannot add vehicle to full station");
    }

    @Test
    public void testStationIsFull() throws StationFullCapacityException {
        for (int i = 0; i < this.station.getCapacity(); i++) {
            this.station.addVehicle(new Bicycle());
        }

        assertTrue(this.station.isFull());
    }

    @Test
    public void testStationIsNotFull() throws StationFullCapacityException {
        Bicycle bike = new Bicycle();

        this.station.addVehicle(bike);

        assertFalse(this.station.isFull());
    }
}
