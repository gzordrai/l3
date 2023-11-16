package src;

import java.util.ArrayList;
import java.util.List;

public abstract class Shipment {
    protected int distance;
    protected List<Goods> goods;

    public Shipment(int distance) {
        this.distance = distance;
        this.goods = new ArrayList<Goods>();
    }

    public abstract int cost();
    public abstract int elementQuantity(Goods goods);
    public abstract int limitQuantity();

    public void add(Goods goods) throws Exception {
        if (this.totalQuantity() + this.elementQuantity(goods) > 100)
            throw new Exception("Too many goods");

        this.goods.add(goods);
    }

    public List<Goods> allGoods() {
        return this.goods;
    }

    public int totalWeight() {
        int weight = 0;

        for (Goods goods : this.goods) {
            weight += goods.getWeight();
        }

        return weight;
    }

    public int totalVolume() {
        int volume = 0;

        for (Goods goods : this.goods) {
            volume += goods.getVolume();
        }

        return volume;
    }

    public int totalQuantity() {
        int total = 0;

        for (Goods goods : this.goods) {
            total += this.elementQuantity(goods);
        }

        return total;
    }
}
