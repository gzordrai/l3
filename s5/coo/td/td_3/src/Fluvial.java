package src;

public class Fluvial extends ByWeight {
    private final int MAX = 300000;

    public Fluvial(int distance) {
        super(distance);
    }

    @Override
    public int cost() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'cost'");
    }

    @Override
    public void add(Goods goods) throws Exception {
        if (this.weight() + goods.getWeight() > this.MAX)
            throw new Exception("Too heavy");
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
