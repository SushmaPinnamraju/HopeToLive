package dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bson.Document;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import databaseconnection.DBCon;
import md5.MD5;
import models.DonorModel;

public class DonorDao {

	public String donorRegistration(DonorModel donorModel) {
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("donors");
			
			Document document2 = new Document();
			 document2.append("email", donorModel.getEmail());
			 
			 Document document3 = new Document();
			 document3.append("phone", donorModel.getPhone());
			 
			 List<Document> documents = new ArrayList<Document>();
		     documents.add(document2);
		     documents.add(document3);
			 
			 Document document4 = new Document(); 	
		     document4.append("$or", documents);
		     FindIterable<Document> findIterable = collection.find(document4);
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 if(iterator.hasNext()) {
				 return "Duplicate Entry";
			 }else{
				 Document document = new Document();
				 document.append("locationId", donorModel.getLocationId());
				 document.append("name", donorModel.getName());
			     document.append("email", donorModel.getEmail());
			     document.append("phone", donorModel.getPhone());
			     document.append("password", donorModel.getPassword());
			    
			     collection.insertOne(document);
			     
			     return "Donor Registred Successfully";
			 }
		}catch(Exception e) {
			e.printStackTrace();
			return "Fails to Donor Registtration";
		}
	}
	public boolean donorLogin(String email, String password, HttpServletResponse response, HttpSession session) {
		System.out.println(email);
		System.out.println(password);
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("donors");
			
			Document document = new Document();
			document.append("email", email);
			document.append("password",MD5.getMd5(password));
			
			FindIterable<Document> findIterable = collection.find(document);
			Iterator<Document> iterator = findIterable.iterator();
			
			if(iterator.hasNext()) {
				Document document2 = iterator.next();
				
				session.setAttribute("donorId",document2.getObjectId("_id").toHexString());
				session.setAttribute("name", document2.getString("name"));
				session.setAttribute("role", "donor");
				
				response.sendRedirect("donorHome.jsp");
				
			}else {
				response.sendRedirect("mMessageFailed.jsp?Msg=Invalid Login Details");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
