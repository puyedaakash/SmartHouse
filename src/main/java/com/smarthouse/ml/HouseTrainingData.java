package com.smarthouse.ml;

public class HouseTrainingData {

    private double area;

    private int bedrooms;

    private int bathrooms;

    private int floors;

    private int age;

    private String district;

    private String city;

    private String location;

    private String propertyType;

    private String furnishing;

    private double price;


    public HouseTrainingData() {
    }


    public HouseTrainingData(
            double area,
            int bedrooms,
            int bathrooms,
            int floors,
            int age,
            String district,
            String city,
            String location,
            String propertyType,
            String furnishing,
            double price) {

        this.area = area;
        this.bedrooms = bedrooms;
        this.bathrooms = bathrooms;
        this.floors = floors;
        this.age = age;
        this.district = district;
        this.city = city;
        this.location = location;
        this.propertyType = propertyType;
        this.furnishing = furnishing;
        this.price = price;
    }


    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }


    public int getBedrooms() {
        return bedrooms;
    }

    public void setBedrooms(int bedrooms) {
        this.bedrooms = bedrooms;
    }


    public int getBathrooms() {
        return bathrooms;
    }

    public void setBathrooms(int bathrooms) {
        this.bathrooms = bathrooms;
    }


    public int getFloors() {
        return floors;
    }

    public void setFloors(int floors) {
        this.floors = floors;
    }


    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }


    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }


    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }


    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }


    public String getPropertyType() {
        return propertyType;
    }

    public void setPropertyType(String propertyType) {
        this.propertyType = propertyType;
    }


    public String getFurnishing() {
        return furnishing;
    }

    public void setFurnishing(String furnishing) {
        this.furnishing = furnishing;
    }


    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }


    @Override
    public String toString() {

        return "HouseTrainingData{" +
                "area=" + area +
                ", bedrooms=" + bedrooms +
                ", bathrooms=" + bathrooms +
                ", floors=" + floors +
                ", age=" + age +
                ", district='" + district + '\'' +
                ", city='" + city + '\'' +
                ", location='" + location + '\'' +
                ", propertyType='" + propertyType + '\'' +
                ", furnishing='" + furnishing + '\'' +
                ", price=" + price +
                '}';
    }
}