package dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import databaseconnection.DBCon;
import models.FundRequestModel;
import models.VerifierModel;

public class FundRequestDao {
public static final String REQUESTED="Requested";
public static final String REQUESTED_CANCELLED_BY_SEEKER="Request Cancelled by Seeker";

public static final String REQUESTED_REJECTED_BY_HOSPITAL="Request Rejected by Hospital";
public static final String REQUESTED_APPORVED_BY_HOSPITAL="Request Apporved by Hospital";
public static final String REQUESTED_CANCELLED_BY_HOSPITAL="Request Cancelled by Hospital";

public static final String REQUESTED_REJECTED_BY_ADMIN="Request Rejected by Admin";
public static final String REQUESTED_CANCELLED_BY_ADMIN="Request Cancelled by Admin";
public static final String REQUESTED_APPORVED_BY_ADMIN="Request Apporved by Admin";

public static final String REQUESTED_REJECTED_BY_VERIFIER="Request Rejected by Verifier";
public static final String REQUESTED_APPORVED_BY_VERIFIER="Request Apporved by Verifier";

public static final String FUND_DONATED="Fund Donated";

	public String fundRequest(FundRequestModel fundRequestModel) {
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("fundRequests");
			
			 FindIterable<Document> findIterable = collection.find();
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 Document document = new Document();
			 document.append("hospitalId", new ObjectId(fundRequestModel.getHospitalId()));
			 document.append("seekerId", new ObjectId(fundRequestModel.getSeekerId()));
			 document.append("cause", fundRequestModel.getCause());
			 document.append("date", new Date());
			 document.append("description", fundRequestModel.getDescription());
			 document.append("reports", fundRequestModel.getReports());
			 document.append("photo", fundRequestModel.getPhoto());
			 document.append("status", REQUESTED);
			 document.append("amountRequired", fundRequestModel.getAmountRequired());
			 
			 collection.insertOne(document);
			 return"Fund Requested Successfully";
		}catch(Exception e) {
			e.printStackTrace();
			return "Failed to create fund Request";
		}
	}
	public List<FundRequestModel> viewFundRequest(String id, String role, String status){
		List<FundRequestModel> fundRequestList = new ArrayList<FundRequestModel>();
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("fundRequests");
			
			Document document2 = new Document();
			
			
	  		if(role.equalsIgnoreCase("seeker")){
	  			document2.append("seekerId", new ObjectId(id));
	  		}else if(role.equalsIgnoreCase("hospital")){
	  			document2.append("hospitalId", new ObjectId(id));
	  			
	  			if(status.equalsIgnoreCase("Requested")) {
	  				document2.append("status", REQUESTED);
	  			}else if(status.equalsIgnoreCase("Rejected")){
	  				
	  				List<Document> statusList = new ArrayList<Document>();
	  				Document document11=new Document();
	  				document11.append("status", REQUESTED_REJECTED_BY_HOSPITAL);
	  				statusList.add(document11);
	  				Document document12=new Document();
	  				document12.append("status", REQUESTED_CANCELLED_BY_HOSPITAL);
	  				statusList.add(document12);
	  				Document document13=new Document();
	  				document13.append("status", REQUESTED_REJECTED_BY_ADMIN);
	  				statusList.add(document13);
	  				Document document14=new Document();
	  				document14.append("status", REQUESTED_REJECTED_BY_VERIFIER);
	  				statusList.add(document14);
	  				Document document15=new Document();
	  				document15.append("status", REQUESTED_CANCELLED_BY_ADMIN);
	  				statusList.add(document15);
	  				
	  
	  				document2.append("$or", statusList);
	  				System.out.println("rejected");
	  			}else if(status.equalsIgnoreCase("Processing")){
	  				List<Document> statusList = new ArrayList<Document>();
	  				Document document11=new Document();
	  				document11.append("status", REQUESTED_APPORVED_BY_HOSPITAL);
	  				statusList.add(document11);
	  				Document document12=new Document();
	  				document12.append("status", REQUESTED_APPORVED_BY_ADMIN);
	  				statusList.add(document12);
	  				Document document13=new Document();
	  				document13.append("status", REQUESTED_APPORVED_BY_VERIFIER);
	  				statusList.add(document13);
	  				
	  				document2.append("$or", statusList);
	  				
	  			}else if(status.equalsIgnoreCase("Completed")){
	  				document2.append("status", FUND_DONATED);
	  			};
	  		}else if(role.equalsIgnoreCase("admin")){
	  			if(status.equalsIgnoreCase("Requested")) {
	  				document2.append("status", REQUESTED_APPORVED_BY_HOSPITAL);
	  			}else if(status.equalsIgnoreCase("Rejected")){
	  				List<Document> statusList = new ArrayList<Document>();
	  				Document document12=new Document();
	  				document12.append("status", REQUESTED_CANCELLED_BY_HOSPITAL);
	  				statusList.add(document12);
	  				Document document13=new Document();
	  				document13.append("status", REQUESTED_REJECTED_BY_ADMIN);
	  				statusList.add(document13);
	  				Document document14=new Document();
	  				document14.append("status", REQUESTED_REJECTED_BY_VERIFIER);
	  				statusList.add(document14);
	  				Document document15=new Document();
	  				document15.append("status", REQUESTED_CANCELLED_BY_ADMIN);
	  				statusList.add(document15);
	  				
	  
	  				document2.append("$or", statusList);
	  				System.out.println("rejected");
	  			}else if(status.equalsIgnoreCase("Processing")){
	  				List<Document> statusList = new ArrayList<Document>();
	  				Document document12=new Document();
	  				document12.append("status", REQUESTED_APPORVED_BY_ADMIN);
	  				statusList.add(document12);
	  				Document document13=new Document();
	  				document13.append("status", REQUESTED_APPORVED_BY_VERIFIER);
	  				statusList.add(document13);
	  				document2.append("$or", statusList);
	  				
	  			}else if(status.equalsIgnoreCase("Completed")){
	  				document2.append("status", FUND_DONATED);
	  			};
	  			
	  		}else if(role.equalsIgnoreCase("donor")){
  				document2.append("status", REQUESTED_APPORVED_BY_VERIFIER);
  				System.out.println("hii");
	  		}else if(role.equalsIgnoreCase("verifier")){
	  			document2.append("verifierId", new ObjectId(id));
	  			if(status.equalsIgnoreCase("Requested")) {
	  				document2.append("status", REQUESTED_APPORVED_BY_ADMIN);
	  			}else if(status.equalsIgnoreCase("Rejected")){
	  				List<Document> statusList = new ArrayList<Document>();
	  				Document document12=new Document();
	  				document12.append("status", REQUESTED_CANCELLED_BY_HOSPITAL);
	  				statusList.add(document12);
	  				Document document14=new Document();
	  				document14.append("status", REQUESTED_REJECTED_BY_VERIFIER);
	  				statusList.add(document14);
	  				Document document15=new Document();
	  				document15.append("status", REQUESTED_CANCELLED_BY_ADMIN);
	  				statusList.add(document15);
	  				document2.append("$or", statusList);
	  				System.out.println("rejected");
	  			}else if(status.equalsIgnoreCase("Processing")){
	  				List<Document> statusList = new ArrayList<Document>();
	  				Document document13=new Document();
	  				document13.append("status", REQUESTED_APPORVED_BY_VERIFIER);
	  				statusList.add(document13);
	  				document2.append("$or", statusList);
	  				
	  			}else if(status.equalsIgnoreCase("Completed")){
	  				document2.append("status", FUND_DONATED);
	  			};
	  		}
			
			FindIterable<Document> findIterable = collection.find(document2);
			Iterator<Document> iterator = findIterable.iterator();
			
			while(iterator.hasNext()) {
				Document document = iterator.next();
				
				FundRequestModel fundRequestModel = new FundRequestModel();
				fundRequestModel.setFundRequestId(document.getObjectId("_id").toHexString());
				fundRequestModel.setHospitalId(document.getObjectId("hospitalId").toHexString());
				fundRequestModel.setSeekerId(document.getObjectId("seekerId").toHexString());
				fundRequestModel.setCause(document.getString("cause"));
				fundRequestModel.setDate(""+document.getDate("date"));
				fundRequestModel.setDescription(document.getString("description"));
				fundRequestModel.setReports(document.getString("reports"));
				fundRequestModel.setPhoto(document.getString("photo"));
				fundRequestModel.setStatus(document.getString("status"));
				fundRequestModel.setAmountRequired(document.getDouble("amountRequired"));
				if(role.equalsIgnoreCase("donor")&&fundRequestModel.getAmountRequired()<=0){
					
				}else {
					fundRequestList.add(fundRequestModel);
				}
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return fundRequestList;
	}
	public void setStatus(String fundRequestId, String status, HttpServletResponse response,String status2) {
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("fundRequests");
		
			Document document = new Document();
			document.append("status", status);
			
			Document document2 = new Document();
			document2.append("$set", document);
			
			Document document3 = new Document();
			document3.append("_id", new ObjectId(fundRequestId));
			
			collection.updateOne(document3, document2);
			
			response.sendRedirect("viewRequestStatus.jsp?status="+status2);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public List<VerifierModel> getVerifiers(String fundRequestId){
		System.out.println(fundRequestId);
		List<VerifierModel> verifiersList = new ArrayList<VerifierModel>();
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> fundRequestsCollection = mongoDatabase.getCollection("fundRequests");
			MongoCollection<Document> hospitalsCollection = mongoDatabase.getCollection("hospitals");
			MongoCollection<Document> verifierCollection = mongoDatabase.getCollection("verifier");
			
			Document document = new Document();
			document.append("_id", new ObjectId(fundRequestId));
			
			FindIterable<Document> findIterable = fundRequestsCollection.find(document);
			Iterator<Document> iterator = findIterable.iterator();
			
			if(iterator.hasNext()) {
				Document document2 = iterator.next();
				System.out.println("in side if1");
				Document document3 = new Document();
				document3.append("_id", document2.getObjectId("hospitalId"));
				
				FindIterable<Document> findIterable2 = hospitalsCollection.find(document3);
				Iterator<Document> iterator2 = findIterable2.iterator();
				
				if(iterator2.hasNext()) {					
					Document document4 = iterator2.next();
					System.out.println("in side if2");
					Document document5 = new Document();
					document5.append("locationId", document4.getObjectId("locationId"));
					
					FindIterable<Document> findIterable3 = verifierCollection.find(document5);
					Iterator<Document> iterator3 = findIterable3.iterator();
					
					while(iterator3.hasNext()) {
						Document document6 = iterator3.next();
						System.out.println("in side the while");
						VerifierModel verifierModel = new VerifierModel();
						verifierModel.setVerifierId(document6.getObjectId("_id").toHexString());
						verifierModel.setLocationId(document6.getObjectId("locationId").toHexString());
						verifierModel.setName(document6.getString("name"));
						verifierModel.setEmail(document6.getString("email"));
						verifierModel.setPhone(document6.getString("phone"));
						verifierModel.setPassword(document6.getString("password"));
						verifierModel.setAddress(document6.getString("address"));
						
						verifiersList.add(verifierModel);
					}
				}
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return verifiersList;
	}
	public String setStatus2(String fundRequestId, String status, String verifierId) {
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("fundRequests");
			
			Document document = new Document();
			document.append("verifierId", new ObjectId(verifierId));
			document.append("status", status);
			
			Document document3 = new Document();
			document3.append("$set", document);
			
			Document document2 = new Document();
			document2.append("_id", new ObjectId(fundRequestId));
			
			collection.updateOne(document2, document3);
			
			return "Assigned Successfully";
		}catch(Exception e) {
			e.printStackTrace();
			return "Failed To Assign";
		}
	}
	public FundRequestModel getFundRequstedById(String fundRequestId) {
		FundRequestModel fundRequestModel = new FundRequestModel();
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("fundRequests");
			
			
			Document document2 = new Document();
			document2.append("_id", new ObjectId(fundRequestId));
			
			FindIterable<Document> findIterable = collection.find(document2);
			Iterator<Document> iterator = findIterable.iterator();
			
			if(iterator.hasNext()) {
				Document document = iterator.next();
				
				fundRequestModel.setFundRequestId(document.getObjectId("_id").toHexString());
				fundRequestModel.setHospitalId(document.getObjectId("hospitalId").toHexString());
				fundRequestModel.setSeekerId(document.getObjectId("seekerId").toHexString());
				fundRequestModel.setCause(document.getString("cause"));
				fundRequestModel.setDate(""+document.getDate("date"));
				fundRequestModel.setDescription(document.getString("description"));
				fundRequestModel.setReports(document.getString("reports"));
				fundRequestModel.setPhoto(document.getString("photo"));
				fundRequestModel.setStatus(document.getString("status"));
				fundRequestModel.setAmountRequired(document.getDouble("amountRequired"));
			
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return fundRequestModel;
	}
}
