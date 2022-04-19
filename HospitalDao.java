package dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import databaseconnection.DBCon;
import md5.MD5;
import models.HospitalModel;

public class HospitalDao {

	public String addHospital(HospitalModel hospitalModel) {
		try {
			 MongoDatabase mongoDatabase= DBCon.getConnection();
			 MongoCollection<Document> collection = mongoDatabase.getCollection("hospitals");
			 
			 Document document = new Document();
			 document.append("email", hospitalModel.getEmail());
			 
			 Document document1 = new Document();
			 document1.append("phone", hospitalModel.getPhone());
			 
			 Document document2 = new Document();
			 document2.append("hospitalCode", hospitalModel.getHospitalCode());
			 
			 Document document5 = new Document();
			 document5.append("accountNumber", hospitalModel.getAccountNumber());
			 
			 List<Document> documents = new ArrayList<Document>();
			 documents.add(document);
			 documents.add(document1);
			 documents.add(document2);
			 
			 Document document3 = new Document();
			 document3.append("$or", documents);			 
			 FindIterable<Document> findIterable = collection.find(document3);
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 if(iterator.hasNext()) {
				 return "Duplicate Details";
			 }else {
				 Document document4 = new Document();
				 document4.append("locationId",new ObjectId( hospitalModel.getLocationId()));
				 document4.append("hospitalName", hospitalModel.getHospitalName());
				 document4.append("hospitalType", hospitalModel.getHospitalType());
				 document4.append("hospitalCode", hospitalModel.getHospitalCode());
				 document4.append("password", hospitalModel.getPassword());
				 document4.append("email", hospitalModel.getEmail());
				 document4.append("phone", hospitalModel.getPhone());
				 document4.append("address", hospitalModel.getAddress());
				 document4.append("accountNumber", hospitalModel.getAccountNumber());
				 document4.append("balance", 0.0d);
				 document4.append("status", "unauthorized");
				 
				 collection.insertOne(document4);
				 return "Hospital Registred Successfully";
			 }
			 
		}catch(Exception e) {
			e.printStackTrace();
			return "Fails to registr Hospital Details";
		}
	}
	public List<HospitalModel> viewHospitals(){
		List<HospitalModel> hospitalList = new ArrayList<HospitalModel>();
		try {
			 MongoDatabase mongoDatabase= DBCon.getConnection();
			 MongoCollection<Document> collection = mongoDatabase.getCollection("hospitals");
			 
			 FindIterable<Document> findIterable = collection.find();
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 while(iterator.hasNext()) {
				 Document document = iterator.next();
				 
				 HospitalModel hospitalModel = new HospitalModel();
				 hospitalModel.setHospitalId(document.getObjectId("_id").toHexString());
				 hospitalModel.setLocationId(document.getObjectId("locationId").toHexString());
				 hospitalModel.setHospitalName(document.getString("hospitalName"));
				 hospitalModel.setHospitalType(document.getString("hospitalType"));
				 hospitalModel.setHospitalCode(document.getString("hospitalCode"));
				 hospitalModel.setEmail(document.getString("email"));
				 hospitalModel.setPhone(document.getString("phone"));
				 hospitalModel.setAddress(document.getString("address"));
				 hospitalModel.setAccountNumber(document.getLong("accountNumber"));
				 hospitalModel.setStatus(document.getString("status"));
				 
				 hospitalList.add(hospitalModel);
				 
			 }
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hospitalList;
	}
	
	public void activateHospital(String hospitalId, String status, HttpServletResponse response) {
		String newstatus=null;
		
		if (status.equalsIgnoreCase("authorized")) {
			newstatus="unauthorized";
		}else {
			newstatus="authorized";
		}
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("hospitals");
			
			Document document = new Document();
			document.append("status", newstatus);
			
			Document document2 = new Document();
			document2.append("$set", document);
			
			Document document3 = new Document();
			document3.append("_id", new ObjectId(hospitalId));
			
			collection.updateOne(document3, document2);
	
			response.sendRedirect("viewHospitals.jsp");
	
		} catch (Exception e) {	
			e.printStackTrace();
		}
	}
	public boolean hospitalLogin(String email, String password, HttpServletResponse response, HttpSession session) {
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("hospitals");
			
			Document document = new Document();
			document.append("email", email);
			document.append("password",MD5.getMd5(password));
			
			FindIterable<Document> findIterable = collection.find(document);
			Iterator<Document> iterator = findIterable.iterator();
			
			if(iterator.hasNext()) {
				Document document2 = iterator.next();
				if(document2.getString("status").equalsIgnoreCase("authorized")) {
					session.setAttribute("hospitalId",document2.getObjectId("_id").toHexString());
					session.setAttribute("hospitalName", document2.getString("hospitalName"));
					session.setAttribute("role", "hospital");
					
					response.sendRedirect("hospitalHome.jsp");
				}else {
					response.sendRedirect("mMessageFailed.jsp?Msg=Hospital Profile Not Activated");
				}
			}else {
				response.sendRedirect("mMessageFailed.jsp?Msg=Invalid Login Details");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public List<HospitalModel> getHospitals(){
		List<HospitalModel> hospitalList = new ArrayList<HospitalModel>();
		try {
			 MongoDatabase mongoDatabase= DBCon.getConnection();
			 MongoCollection<Document> collection = mongoDatabase.getCollection("hospitals");
			 
			 FindIterable<Document> findIterable = collection.find();
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 while(iterator.hasNext()) {
				 Document document = iterator.next();
				 
				 HospitalModel hospitalModel = new HospitalModel();
				 hospitalModel.setHospitalId(document.getObjectId("_id").toHexString());
				 hospitalModel.setLocationId(document.getObjectId("locationId").toHexString());
				 hospitalModel.setHospitalName(document.getString("hospitalName"));
				 hospitalModel.setHospitalType(document.getString("hospitalType"));
				 hospitalModel.setHospitalCode(document.getString("hospitalCode"));
				 hospitalModel.setEmail(document.getString("email"));
				 hospitalModel.setPhone(document.getString("phone"));
				 hospitalModel.setAddress(document.getString("address"));
				 hospitalModel.setAccountNumber(document.getLong("accountNumber"));
				 hospitalModel.setStatus(document.getString("status"));
				 
				 hospitalList.add(hospitalModel);
				 
			 }
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hospitalList;
	}
	public HospitalModel getHospitalById(String hospitalId) {
		
		HospitalModel hospitalModel = new HospitalModel();
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("hospitals");
			
			Document document =new Document();
			document.append("_id", new ObjectId(hospitalId));
			
			FindIterable<Document> findIterable = collection.find(document);
			Iterator<Document> iterator = findIterable.iterator();
			
			while(iterator.hasNext()) {
				Document document2 = iterator.next();
				
				hospitalModel.setHospitalId(hospitalId);
				hospitalModel.setLocationId(document2.getObjectId("locationId").toHexString());
				hospitalModel.setHospitalName(document2.getString("hospitalName"));
				hospitalModel.setHospitalType(document2.getString("hospitalType"));
				hospitalModel.setHospitalCode(document2.getString("hospitalCode"));
				hospitalModel.setEmail(document2.getString("email"));
				hospitalModel.setPhone(document2.getString("phone"));
				hospitalModel.setAddress(document2.getString("address"));
				hospitalModel.setAccountNumber(document2.getLong("accountNumber"));
				hospitalModel.setStatus(document2.getString("status"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hospitalModel;
	}
}
