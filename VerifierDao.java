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
import emailsending.Email;
import md5.MD5;
import models.HospitalModel;
import models.VerifierModel;

public class VerifierDao {

	public String addVerifier(VerifierModel verifierModel) {
		try {
			 MongoDatabase mongoDatabase= DBCon.getConnection();
			 MongoCollection<Document> collection = mongoDatabase.getCollection("verifier");
			
			 Document document2 = new Document();
			 document2.append("email", verifierModel.getEmail());
			 
			 Document document3 = new Document();
			 document3.append("phone", verifierModel.getPhone());
			 
			 
		     List<Document> documents = new ArrayList<Document>();
		     documents.add(document2);
		     documents.add(document3);
		     
		     Document document4 = new Document(); 	
		     document4.append("$or", documents);
		     FindIterable<Document> findIterable = collection.find(document4);
			 Iterator<Document> iterator = findIterable.iterator();
		     if(iterator.hasNext()) {
		    	 return "Duplicate Details";
		     } else {
				 Document document = new Document();
				 document.append("locationId", new ObjectId(verifierModel.getLocationId()));
				 document.append("name", verifierModel.getName());
			     document.append("email", verifierModel.getEmail());
			     document.append("phone", verifierModel.getPhone());
			     document.append("password", verifierModel.getPassword());
			     document.append("address", verifierModel.getAddress());
			     collection.insertOne(document);
				 Email.sendEmail("Verifier Registration", "Your Verifier Account Created Successfully.Your Login Credentails Are Phone: "+verifierModel.getEmail()+" Password:"+ verifierModel.getPassword(), "Email.getEmail()");
			     return "Verifier added Successfully";
		     }

		    
		}catch(Exception e) {
			e.printStackTrace();
			return "Fails to add Verifier";
		}
	}
	public List<VerifierModel> viewVerifiers(){
		List<VerifierModel>  verifierList= new ArrayList<VerifierModel>();
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("verifier");
			
			FindIterable<Document> findIterable = collection.find();
			Iterator<Document> iterator = findIterable.iterator();
			
			while(iterator.hasNext()) {
				Document document= iterator.next();
				
				VerifierModel verifierModel = new VerifierModel();
				verifierModel.setVerifierId(document.getObjectId("_id").toHexString());
				verifierModel.setLocationId(document.getObjectId("locationId").toHexString());
				verifierModel.setName(document.getString("name"));
				verifierModel.setEmail(document.getString("email"));
				verifierModel.setPhone(document.getString("phone"));
				verifierModel.setPassword(document.getString("password"));
				verifierModel.setAddress(document.getString("address"));
				
				verifierList.add(verifierModel);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return verifierList;
	}
	public boolean verifierLogin(String email, String password, HttpServletResponse response, HttpSession session) {
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("verifier");
			
			Document document = new Document();
			document.append("email", email);
			document.append("password",MD5.getMd5(password));
			
			FindIterable<Document> findIterable = collection.find(document);
			Iterator<Document> iterator = findIterable.iterator();
			
			if(iterator.hasNext()) {
				Document document2 = iterator.next();
				
				session.setAttribute("verifierId",document2.getObjectId("_id").toHexString());
				session.setAttribute("name", document2.getString("name"));
				session.setAttribute("role", "verifier");
				
				response.sendRedirect("verifierHome.jsp");
				
			}else {
				response.sendRedirect("mMessageFailed.jsp?Msg=Invalid Login Details");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
//	public List<VerifierModel> getVerifirsById(String hospitalId){
//		List<VerifierModel> verifierList = new ArrayList<VerifierModel>();
//		try {
//			MongoDatabase mongoDatabase= DBCon.getConnection();
//			MongoCollection<Document> collection = mongoDatabase.getCollection("hospitals");
//			
//			Document document = new Document();
//			document.append("_id", new ObjectId(hospitalId));
//			
//			FindIterable<Document> findIterable = collection.find(document);
//			Iterator<Document> iterator = findIterable.iterator();
//			
//			if(iterator.hasNext()) {
//				Document document2 = iterator.next();
//				
//				HospitalModel hospitalModel = new HospitalModel();
//				hospitalModel.setHospitalId(document2.getObjectId("_id").toHexString());
//				hospitalModel.setLocationId(document2.getObjectId("locationId").toHexString());
//				hospitalModel.setHospitalName(document2.getString("hospitalName"));
//				hospitalModel.setHospitalType(document2.getString("hospitalType"));
//				hospitalModel.setHospitalCode(document2.getString("hospitalCode"));
//				hospitalModel.setEmail(document2.getString("email"));
//				hospitalModel.setPhone(document2.getString("phone"));
//				hospitalModel.setAddress(document2.getString("address"));
//				hospitalModel.setAccountNumber(document2.getLong("accountNumber"));
//				hospitalModel.setStatus(document2.getString("status"));
//				
//				MongoCollection<Document> collection2 = mongoDatabase.getCollection("verifier");
//				
//				Document document3 = new Document();
//				document.append("_id", new ObjectId(hospitalId));
//				
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		return verifierList;
//	}
}
