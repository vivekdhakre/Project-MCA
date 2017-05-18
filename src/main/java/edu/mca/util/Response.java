package edu.mca.util;

/**
 * Created by Vivek on 18/5/17.
 */
public class Response {

    String storeName;
    int sum;
    int count;

    public Response(String storeName, int sum, int count) {
        this.storeName = storeName;
        this.sum = sum;
        this.count = count;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public int getSum() {
        return sum;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
