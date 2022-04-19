package dao;

import java.util.Iterator;

import org.bson.Document;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import databaseconnection.DBCon;
import models.FundAccountModel;

public class FundAccountDao {

	public FundAccountModel getFundAccount() {
		FundAccountModel fundAccountModel = new FundAccountModel();
		try {
			 MongoDatabase mongoDatabase= DBCon.getConnection();
			 MongoCollection<Document> collection = mongoDatabase.getCollection("fundAccount");
			 
			 FindIterable<Document> findIterable = collection.find();
			 Iterator<Document> iterator = findIterable.iterator();
			 
			 if(iterator.hasNext()) {
				 Document document = iterator.next();
				 fundAccountModel.setFundAccountId(document.getObjectId("_id").toHexString());
				 fundAccountModel.setAccountNumber(document.getLong("accountNumber"));
				 fundAccountModel.setAccountBalance(document.getDouble("accountBalance"));
				 
			 }else{
				 Document document = new Document();
				 document.append("accountNumber", 123456789l);
				 document.append("accountBalance", 0.0d);
				 collection.insertOne(document);
				 getFundAccount();
			 }
		}catch(Exception e) {
			e.printStackTrace();
		}
		return fundAccountModel;
	}
}
