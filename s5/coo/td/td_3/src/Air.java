package src;

public class Air extends Shipment {

    public Air(int distance) {
        super(distance);
        //TODO Auto-generated constructor stub
    }

    @Override
    public int cost() {
        return (int) (this.distance * Math.sqrt(this.totalWeight()));
    }

    @Override
    public void add(Goods goods) throws Exception {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'add'");
    }

    @Override
    public int elementQuantity(Goods goods) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'elementQuantity'");
    }

    @Override
    public int limitQuantity() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'limitQuantity'");
    }
    
}
