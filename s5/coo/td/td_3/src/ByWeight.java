package src;

public abstract class ByWeight extends Shipment {

    public ByWeight(int distance) {
        super(distance);
    }

    @Override
    public abstract int cost();

    public int weight() {
        return 0;
    }

    @Override
    public int elementQuantity(Goods goods) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'elementQuantity'");
    }
    
}
