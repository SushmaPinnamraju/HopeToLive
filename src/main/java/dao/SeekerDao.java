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
import models.FundRequestModel;
import models.SeekerModel;

public class SeekerDao {

	public String seekeRegistration(SeekerModel seekerModel) {
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("seekers");
			
			 Document document2 = new Document();
			 document2.append("email", seekerModel.getEmail());
			 
			 Document document3 = new Document();
			 document3.append("phone", seekerModel.getPhone());
			 
			 List<Document> documents = new ArrayList<Document>();
		     documents.add(document2);
		     documents.add(document3);
			 
			 Document document4 = new Document(); 	
		     document4.append("$or", documents);
		     FindIterable<Document> findIterable = collection.find(document4);
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 if(iterator.hasNext()) {
				 return "Duplicate Details";
			 }else{
				 Document document = new Document();
				 document.append("locationId",new ObjectId(seekerModel.getLocationId()));
				 document.append("name", seekerModel.getName());
			     document.append("email", seekerModel.getEmail());
			     document.append("phone", seekerModel.getPhone());
			     document.append("password", seekerModel.getPassword());
			    
			     collection.insertOne(document);
			     
			     return "Seeker Registred Successfully";
			 }
		}catch(Exception e) {
			e.printStackTrace();
			return "Fails to seeker Register";
		}
	}
	public boolean seekerLogin(String email, String password, HttpServletResponse response, HttpSession session) {
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("seekers");
			
			Document document = new Document();
			document.append("email", email);
			document.append("password",MD5.getMd5(password));
			
			FindIterable<Document> findIterable = collection.find(document);
			Iterator<Document> iterator = findIterable.iterator();
			
			if(iterator.hasNext()) {
				Document document2 = iterator.next();
				
				session.setAttribute("seekerId",document2.getObjectId("_id").toHexString());
				session.setAttribute("name", document2.getString("name"));
				session.setAttribute("role", "seeker");
				
				response.sendRedirect("seekerHome.jsp");
				
			}else {
				response.sendRedirect("mMessageFailed.jsp?Msg=Invalid Login Details");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public SeekerModel getSeekerById(String seekerId) {
		SeekerModel seekerModel = new SeekerModel();
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("seekers");
			
			Document document =new Document();
			document.append("_id", new ObjectId(seekerId));
			
			FindIterable<Document> findIterable = collection.find(document);
			Iterator<Document> iterator = findIterable.iterator();
			
			while(iterator.hasNext()) {
				Document document2 = iterator.next();
				
				seekerModel.setSeekerId(seekerId);
				seekerModel.setLocationId(document2.getObjectId("locationId").toHexString());
				seekerModel.setName(document2.getString("name"));
				seekerModel.setEmail(document2.getString("email"));
				seekerModel.setPhone(document2.getString("phone"));
				seekerModel.setPassword(document2.getString("password"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return seekerModel;
	}
}
