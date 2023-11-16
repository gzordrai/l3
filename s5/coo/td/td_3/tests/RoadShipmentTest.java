package tests;

import src.Goods;
import src.Road;
import src.Shipment;

public class RoadShipmentTest extends ShipmentTest {
    public Shipment createShipment() throws Exception {
        Shipment shipment = new Road(100);

        shipment.add(new Goods(10, 20));

        return shipment;
    }

    public Goods createOKGoods() {
        return new Goods(30, 40);
    }

    public Goods createKOGoods() {
        return new Goods(1000000, 1000000);
    }

    public int expectedCost() {
        return 4 * 100 * (20 + 40);
    }
    // @Test
    // public void addGoodsOK() throws Exception {
    //     Goods goods = new Goods(30, 40);
    //     Shipment shipment = new Road(100);

    //     assertEquals(0, shipment.totalQuantity());
    //     assertFalse(shipment.allGoods().contains(goods));

    //     shipment.add(goods);

    //     assertEquals(1, shipment.totalQuantity());
    //     assertTrue(shipment.allGoods().contains(goods));
    //     assertEquals(16000, shipment.cost());
    //     assertEquals(40, shipment.totalQuantity());
    // }
}
