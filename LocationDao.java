package dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import databaseconnection.DBCon;
import models.LocationModel;

public class LocationDao {

	public String addLocation(LocationModel locationModel) {
		try {
			 MongoDatabase mongoDatabase= DBCon.getConnection();
			 MongoCollection<Document> collection = mongoDatabase.getCollection("location");			 
			 
			 Document document = new Document();
			 document.append("locationName", locationModel.getLocationName());
			 
			 FindIterable<Document> findIterable = collection.find(document);
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 if(iterator.hasNext()) {
				 return"Duplicate Details";
			 }else {
				 collection.insertOne(document);
				 return"Location added Successfully";
			 }			 			 			 
		     
		}catch(Exception e) {
			e.printStackTrace();
			return "Fails to Add Location";
		}
	}
	public List<LocationModel> viewLocations(){
		List<LocationModel> locationList=new ArrayList<LocationModel>();
		try {
			 MongoDatabase mongoDatabase= DBCon.getConnection();
			 MongoCollection<Document> collection = mongoDatabase.getCollection("location");
			 
			 FindIterable<Document> findIterable = collection.find();
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 while(iterator.hasNext()) {
				 Document document= iterator.next();
				 
				 LocationModel locationModel = new LocationModel();
				 locationModel.setLocationId(document.getObjectId("_id").toHexString());
				 locationModel.setLocationName(document.getString("locationName"));
				 
				 locationList.add(locationModel);
			 }
		}catch(Exception e) {
			e.printStackTrace();
		}
		return locationList;
	}
	public List<LocationModel> getLocations(){
		List<LocationModel> locationList=new ArrayList<LocationModel>();
		try {
			 MongoDatabase mongoDatabase= DBCon.getConnection();
			 MongoCollection<Document> collection = mongoDatabase.getCollection("location");
			 
			 FindIterable<Document> findIterable = collection.find();
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 while(iterator.hasNext()) {
				 Document document= iterator.next();
				 
				 LocationModel locationModel = new LocationModel();
				 locationModel.setLocationId(document.getObjectId("_id").toHexString());
				 locationModel.setLocationName(document.getString("locationName"));
				 
				 locationList.add(locationModel);
			 }
		}catch(Exception e) {
			e.printStackTrace();
		}
		return locationList;
	}
	public LocationModel getLocationsById(String locationId) {
		LocationModel locationModel = new LocationModel();
		try {
			 MongoDatabase mongoDatabase= DBCon.getConnection();
			 MongoCollection<Document> collection = mongoDatabase.getCollection("location");
			 
			 Document document2 =new Document();
			 document2.append("_id", new ObjectId(locationId));
			 
			 FindIterable<Document> findIterable = collection.find(document2);
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 while(iterator.hasNext()) {
				 Document document= iterator.next();
				 
				 locationModel.setLocationId(locationId);
				 locationModel.setLocationName(document.getString("locationName"));
			 }
		}catch(Exception e) {
			e.printStackTrace();
		}
		return locationModel;
	}
}
