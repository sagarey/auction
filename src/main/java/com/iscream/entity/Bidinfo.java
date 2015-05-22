package com.iscream.entity;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Timestamp;

/**
 * Created by lyace on 2015/4/26.
 */
@Entity
public class Bidinfo {
    private int id;
    private int userId;
    private String name;
    private int goodsId;
    private String title;
    private int offer;
    private Timestamp deadline;
    private String status;
    private Timestamp createdAt;
    private int price;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "user_id")
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "goods_id")
    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    @Basic
    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "offer")
    public int getOffer() {
        return offer;
    }

    public void setOffer(int offer) {
        this.offer = offer;
    }

    @Basic
    @Column(name = "deadline")
    public Timestamp getDeadline() {
        return deadline;
    }

    public void setDeadline(Timestamp deadline) {
        this.deadline = deadline;
    }

    @Basic
    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Bidinfo bidinfo = (Bidinfo) o;

        if (id != bidinfo.id) return false;
        if (userId != bidinfo.userId) return false;
        if (goodsId != bidinfo.goodsId) return false;
        if (offer != bidinfo.offer) return false;
        if (name != null ? !name.equals(bidinfo.name) : bidinfo.name != null) return false;
        if (title != null ? !title.equals(bidinfo.title) : bidinfo.title != null) return false;
        if (deadline != null ? !deadline.equals(bidinfo.deadline) : bidinfo.deadline != null) return false;
        if (status != null ? !status.equals(bidinfo.status) : bidinfo.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + userId;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + goodsId;
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + offer;
        result = 31 * result + (deadline != null ? deadline.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "created_at")
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Basic
    @Column(name = "price")
    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}
