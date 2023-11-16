package fil.l3.coo.station.exceptions;

public class StationFullCapacityException extends Exception {
    public StationFullCapacityException() {
        super("Cannot add vehicle to full station");
    }
}
