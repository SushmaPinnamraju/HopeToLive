package dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import databaseconnection.DBCon;
import models.DonationReceivedModel;

public class DonationReceivedDao {

	public String donationReceived(DonationReceivedModel donationReceivedModel) {
	
		try {
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("donationReceived");
			MongoCollection<Document> fundAccountCollection = mongoDatabase.getCollection("fundAccount");
			MongoCollection<Document> hospitalsCollection = mongoDatabase.getCollection("hospitals");
			MongoCollection<Document> fundRequestsCollection = mongoDatabase.getCollection("fundRequests");
			Document document = new Document();
			document.append("senderId", new ObjectId(donationReceivedModel.getSenderId()));
			document.append("sender", donationReceivedModel.getSender());
			document.append("receiverId", new ObjectId(donationReceivedModel.getReceiverId()));
			document.append("receiver", donationReceivedModel.getReceiver());
			document.append("amount", donationReceivedModel.getAmount());
			document.append("donationType",donationReceivedModel.getDonationType() );
			if(donationReceivedModel.getFundRequestId()!=null) {
				document.append("fundRequestId", new ObjectId(donationReceivedModel.getFundRequestId()));
			}
			document.append("date", new Date());
			
			
			if(donationReceivedModel.getReceiver().equalsIgnoreCase("Admin")) {
				System.out.println("inside if1");
				Document document2=new Document();
				document2.append("_id", new ObjectId(donationReceivedModel.getReceiverId()));
				 FindIterable<Document> findIterable = fundAccountCollection.find(document2);
				 Iterator<Document> iterator = findIterable.iterator();
				 if(iterator.hasNext()) {
					 System.out.println("inside the if2");
					 Document document3 = iterator.next();
					 Document document4=new Document();
					 document4.append("accountBalance", (document3.getDouble("accountBalance")+donationReceivedModel.getAmount()));
					 
					 Document document5=new Document();
					 document5.append("$set", document4);
					 
					 Document document6=new Document();
					 document6.append("_id", document3.getObjectId("_id"));
					 fundAccountCollection.updateOne(document6, document5);
				}
				 collection.insertOne(document);
			}else {
				Document document22=new Document();
				document22.append("_id", new ObjectId(donationReceivedModel.getSenderId()));
				 FindIterable<Document> findIterable22 = fundAccountCollection.find(document22);
				 Iterator<Document> iterator22 = findIterable22.iterator();
				 if(iterator22.hasNext()) {
					 Document document33 = iterator22.next();
					 Document document44=new Document();
					 if(document33.getDouble("accountBalance")<donationReceivedModel.getAmount()) {
						 return "Insufficient Funds";
					 }
					 document44.append("accountBalance", (document33.getDouble("accountBalance")-donationReceivedModel.getAmount()));
					 
					 Document document55=new Document();
					 document55.append("$set", document44);
					 
					 Document document66=new Document();
					 document66.append("_id", document33.getObjectId("_id"));
					 fundAccountCollection.updateOne(document66, document55);
				} 
				 
				 Document document2=new Document();
				 document2.append("_id", new ObjectId(donationReceivedModel.getReceiverId()));
				 FindIterable<Document> findIterable = hospitalsCollection.find(document2);
				 Iterator<Document> iterator = findIterable.iterator();
				 if(iterator.hasNext()) {
					 Document document3 = iterator.next();
					 Document document4=new Document();
					 document4.append("balance", (document3.getDouble("balance")+donationReceivedModel.getAmount()));
					 
					 Document document5=new Document();
					 document5.append("$set", document4);
					 
					 Document document6=new Document();
					 document6.append("_id", document3.getObjectId("_id"));
					 hospitalsCollection.updateOne(document6, document5);
					 
					 Document document7=new Document();
					 document7.append("_id", new ObjectId(donationReceivedModel.getFundRequestId()));
					 FindIterable<Document> findIterable2 = fundRequestsCollection.find(document7);
					 Iterator<Document> iterator2 = findIterable2.iterator();
					 if(iterator2.hasNext()) {
						 System.out.println("inside the else3");
						 Document document8 = iterator2.next();
						 Document document9=new Document();
						 document9.append("amountRequired", document8.getDouble("amountRequired")-donationReceivedModel.getAmount());
						 
						 Document document10=new Document();
						 document10.append("$set", document9);
						 
						 Document document11=new Document();
						 document11.append("_id", document8.getObjectId("_id"));
						 fundRequestsCollection.updateOne(document11, document10);
					 }
					 
						
				 }
				 collection.insertOne(document);
			}
			return "Amount Donated Successfully";
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "Fails To Donate Amount";
	} 
	public List<DonationReceivedModel> getTransactions(String role,String id){
	
		List<DonationReceivedModel> donationReceivedModelList = new ArrayList<DonationReceivedModel>();
		MongoDatabase mongoDatabase= DBCon.getConnection();
		MongoCollection<Document> collection = mongoDatabase.getCollection("donationReceived");
		Document document=new Document();
		document.append("receiverId", new ObjectId(id));
		Document document2=new Document();
		document2.append("senderId", new ObjectId(id));
		List<Document> documents= new ArrayList<Document>();
		documents.add(document);
		documents.add(document2);
		
		Document document3=new Document();
		document3.append("$or", documents);
		System.out.println("in");
		FindIterable<Document> findIterable = collection.find(document3);
		System.out.println("in3");
		Iterator<Document> iterator = findIterable.iterator();
		
		while(iterator.hasNext()) {
			Document document4 = iterator.next();
			DonationReceivedModel donationReceivedModel=new DonationReceivedModel();
			donationReceivedModel.setDonationReceivedId(document4.getObjectId("_id").toHexString());

			donationReceivedModel.setSenderId(document4.getObjectId("senderId").toHexString());
			donationReceivedModel.setSender(document4.getString("sender"));
			donationReceivedModel.setReceiverId(document4.getObjectId("receiverId").toHexString());
			donationReceivedModel.setReceiver(document4.getString("receiver"));
			donationReceivedModel.setAmount(document4.getDouble("amount"));
			donationReceivedModel.setDonationType(document4.getString("donationType"));
			try {
				donationReceivedModel.setFundRequestId(document4.getObjectId("fundRequestId").toHexString());
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			donationReceivedModel.setDate(""+document4.getDate("date"));
			donationReceivedModelList.add(donationReceivedModel);
		}
		return donationReceivedModelList;
	}
	public String getPersonDetais(String id, String role) {
		MongoDatabase mongoDatabase= DBCon.getConnection();
		MongoCollection<Document> hospitalsCollection = mongoDatabase.getCollection("hospitals");
		MongoCollection<Document> donorsCollection = mongoDatabase.getCollection("donors");
		try {
			if(role.equalsIgnoreCase("Admin")) {
				return "Administrator";
			}else if(role.equalsIgnoreCase("donor")) {
				Document document=new Document();
				document.append("_id", new ObjectId(id));
				FindIterable<Document> findIterable = donorsCollection.find(document);
				Iterator<Document> iterator = findIterable.iterator();
				if(iterator.hasNext()) {
					Document document2 = iterator.next();
					return document2.getString("name")+"<br>"+document2.getString("phone");
				}
			}else if(role.equalsIgnoreCase("hospital")) {
				Document document=new Document();
				document.append("_id", new ObjectId(id));
				FindIterable<Document> findIterable = hospitalsCollection.find(document);
				Iterator<Document> iterator = findIterable.iterator();
				if(iterator.hasNext()) {
					Document document2 = iterator.next();
					return document2.getString("hospitalName")+"<br>"+document2.getString("phone");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public double getDonationAmount(String fundRequestId) {
		try {
			double TotalAmout=0.0d;
			MongoDatabase mongoDatabase= DBCon.getConnection();
			MongoCollection<Document> collection = mongoDatabase.getCollection("donationReceived");
			
			Document document = new Document();
			document.append("fundRequestId", new ObjectId(fundRequestId));
			
			FindIterable<Document> findIterable = collection.find(document);
			Iterator<Document> iterator = findIterable.iterator();
			
			while(iterator.hasNext()) {
				System.out.println("innnn");
				Document document2 = iterator.next();
				if(document2.getString("receiver").equalsIgnoreCase("Hospital")) {
					TotalAmout = TotalAmout + document2.getDouble("amount");
				}
			}
			return TotalAmout;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0.0;
	}
}
