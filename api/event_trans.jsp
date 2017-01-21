<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

Vector<String> user_id =  new Vector<String>();
Vector<String> grid_id =  new Vector<String>();
Vector<String> aqi =  new Vector<String>();
Vector<String> co_avg =  new Vector<String>();
Vector<String> no2_avg =  new Vector<String>();
Vector<String> o3_avg =  new Vector<String>();
Vector<String> so2_avg =  new Vector<String>();
Vector<String> pm25_avg =  new Vector<String>();
Vector<String> rad =  new Vector<String>();
Vector<String> tstamp =  new Vector<String>();
Vector<String> lat =  new Vector<String>();
Vector<String> lon =  new Vector<String>();
    
    


 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
	  
	  String sql = "select user_id,grid_id,aqi,co_avg,no2_avg,o3_avg,so2_avg,pm25_avg,rad,tstamp,lat,lon from event_trans ";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {
		user_id.addElement(rs.getString("user_id"));				
		grid_id.addElement(rs.getString("grid_id"));		
		aqi.addElement(rs.getString("aqi"));
       co_avg.addElement(rs.getString("co_avg"));
       no2_avg.addElement(rs.getString("no2_avg"));
       o3_avg.addElement(rs.getString("o3_avg"));
       so2_avg.addElement(rs.getString("so2_avg"));
       pm25_avg.addElement(rs.getString("pm25_avg"));
       rad.addElement(rs.getString("rad"));
       tstamp.addElement(rs.getString("tstamp"));
       lat.addElement(rs.getString("lat"));
       lon.addElement(rs.getString("lon"));
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

String jsonStr = "[";
for(int i=0; i<user_id.size(); i++){
	
	jsonStr += "{\"id\":\""+user_id.elementAt(i)+"\",";	
	jsonStr += "\"grid_id\":\""+grid_id.elementAt(i)+"\",";
	jsonStr += "\"co\":\""+co_avg.elementAt(i)+"\",";
	jsonStr += "\"no2\":\""+no2_avg.elementAt(i)+"\",";
	jsonStr += "\"o3\":\""+o3_avg.elementAt(i)+"\",";
	jsonStr += "\"so2\":\""+so2_avg.elementAt(i)+"\",";
	jsonStr += "\"pm25\":\""+pm25_avg.elementAt(i)+"\",";
	jsonStr += "\"radio\":\""+rad.elementAt(i)+"\",";	
	jsonStr += "\"lat\":\""+lat.elementAt(i)+"\",";
	jsonStr += "\"lon\":\""+lon.elementAt(i)+"\",";
	jsonStr += "\"timestamp\":\""+tstamp.elementAt(i)+"\"}";
	
		if((i+1) != user_id.size()){ 
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>