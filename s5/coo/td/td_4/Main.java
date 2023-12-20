package td_4;

import java.util.Set;

public class Main {
    private Set<Ride> rides;

    public void discount(float pourcent) {
        for (Ride ride : rides) {
            ride.setPricePolicy(null); // déduire la pourcentage du prix via un new Discount
        }
    }
}