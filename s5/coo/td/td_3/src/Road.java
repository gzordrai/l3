package src;

public class Road extends ByWeight {
    private static final int MAX = 38000;

    public Road(int distance) {
        super(distance);
    }

    @Override
    public int cost() {
        return 4 * this.distance * this.totalQuantity();
    }

    public int limitQuantity() {
        return Road.MAX;
    }

    @Override
    public int elementQuantity(Goods goods) {
        return goods.getWeight();
    }
}
