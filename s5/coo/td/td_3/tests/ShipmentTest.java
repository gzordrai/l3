package tests;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertThrows;

import org.junit.Test;

import src.Goods;
import src.Shipment;

public abstract class ShipmentTest {
    public abstract Shipment createShipment() throws Exception;
    public abstract Goods createOKGoods();
    public abstract Goods createKOGoods();
    public abstract int expectedCost();

    @Test
    public void addGoodsOK() throws Exception {
        Shipment shipment = createShipment();
        Goods goods = createOKGoods();
        int quantityBefore = shipment.totalQuantity();

        shipment.add(goods);

        assertTrue(shipment.allGoods().contains(goods));
        assertEquals(expectedCost(), shipment.cost());
        assertEquals(quantityBefore + shipment.elementQuantity(goods), shipment.totalQuantity());
    }

    @Test
    public void addGoodsKO() throws Exception {
        Shipment shipment = createShipment();
        Goods goods = createKOGoods();
        int costBefore = shipment.cost();

        assertThrows(Exception.class, () -> {
            shipment.add(goods);
        });
        assertFalse(shipment.allGoods().contains(goods));
        assertEquals(costBefore, shipment.cost());
    }
}
