package fil.l3.coo;

import fil.l3.coo.vehicle.Bicycle;
import fil.l3.coo.vehicle.Vehicle;
import fil.l3.coo.vehicle.equipement.*;

/**
 * The Main class.
 * @author Mohamed Zidani - Thibault Tisserand
 */
public class Main {

    public static void main(String[] args) {
        Vehicle b = new Bicycle();
        System.out.println(b);                      // L'appel à toString() est fait automatiquement
        b = new Basket(b);
        System.out.println(b);
        b = new ElectricMotor(b);
        System.out.println(b);
        b = new Foldable(b);
        System.out.println(b);
        b = new LuggageRack(b);
        System.out.println(b);

    }

}
