package databaseconnection;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

public class DBCon {

	static MongoDatabase mongoDatabase;
	public static MongoDatabase getConnection() {
		if(mongoDatabase==null) {
			MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
			mongoDatabase = mongoClient.getDatabase("crowdFunding");
			System.out.println("connectoin created");
		}
		 return mongoDatabase;
	}
}
