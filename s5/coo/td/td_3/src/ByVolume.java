package src;

public abstract class ByVolume extends Shipment {

    public ByVolume(int distance) {
        super(distance);
    }

    @Override
    public abstract int cost();

    @Override
    public int elementQuantity(Goods goods) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'elementQuantity'");
    }
    
}
