<!DOCTYPE html>
<%@page pageEncoding="UTF-8" language="java"%>
<%@page contentType="text/html;charset=UTF-8"%>
<html>
	<head>
		<meta charset="utf-8">
		<style>
			table {
				border-collapse: collapse;
			}
			form {
				margin: 10px 630px;
				padding: 5px;
			}
			input {
				width: 70px;
			}
			th, td {
				padding: 3px 4px;
				border: 1px solid black;
			}
			th {
				background-color: #A52A2A;
			}
			td {
				background-color: #DEB887;			
			}
		</style>
	</head>
<body>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%

	String driverName = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String dbName = "transportas";
	String userId = "root";
	String password = "";

	Connection connection = null;
	Statement statement_take = null;
	Statement statement_change = null;
	ResultSet resultSet = null;
	int resultSetChange;

%>
<h2 align="center"><strong>Retrieve data from database in jsp</strong></h2>
<form method="post" action="">
	<table>
		<tr>
			<th>Modelis</th>
			<td>
				<input type="text" name="modelis" required>
			</td>
		</tr>
		<tr>
			<th>Metai</th>
			<td>
				<input type="number" name="metai" value="2010">
			</td>
		</tr>
		<tr>
			<th>Rida</th>
			<td>
				<input type="number" name="rida" value="100000">
			</td>
		</tr>
		<tr>
			<td colspan="2">
			 
				<input type="button" name="clear" value="valyti"> 
				<input type="submit" name="add" value="papildyti">
			</td>
		</tr>
	</table>
		<input type="hidden" name="id_auto" value="0">
</form>
<table align="center">
<tr>
</tr>
<tr>
	<th>Veiksmai</th>
	<th>Modelis</th>
	<th>Metai</th>
	<th>Rida</th>
</tr>
<%
	String[] lent_auto  = { "id_auto", "modelis", "metai", "rida" };
	String[] lauk_auto = new String [ lent_auto.length ];
	try{
	     
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");		
		
	} catch(Exception e) {}

	try { 
	
		connection = DriverManager.getConnection ( connectionUrl + dbName + "?useUnicode=yes&characterEncoding=UTF-8", userId, password );
		String add; 
		
		if ( ( ( add = request.getParameter("add")  ) != null ) && add.equals ( "papildyti" ) ) {
		
																																					// Miestai miestas = new Miestai ( lent_miestu );
																																					// miestas.takeFromParams ( request );

			for ( int i = 1; i<lent_auto.length; i++ ) {
			
				lauk_auto [ i ] = request.getParameter ( lent_auto [ i ] );
			}

			String sql_ins = "";
			String comma = "";
			
			for ( int i = 1; i < lent_auto.length; i++ ) {
			
				sql_ins =  sql_ins + comma  + "'" + lauk_auto [ i ] + "'";
				comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
			}
			
			sql_ins = 
				"INSERT INTO `das_auto`"
				+ " ( `modelis`, `metai`, `rida` )"
				+ " VALUES ( "			
				+ sql_ins
				+ " )";

			out.println ( sql_ins );

			statement_change = connection.createStatement();
			resultSetChange = statement_change.executeUpdate(sql_ins);			
			
		 } else {
		 
			if ( add != null ) {

				out.println ( add );
			}
		 } 
		
		statement_take = connection.createStatement();		
		String sql ="SELECT * FROM `das_auto`  WHERE 1";

		resultSet = statement_take.executeQuery(sql);
		 
		while( resultSet.next() ){
%>
<tr>
	<td><input type="button" class="record_edit" data-id_miesto="" value="&#9998;"></td>
<%
		for ( int i = 1; i < lauk_auto.length; i++ ) {
%>
	<td><%= resultSet.getString (  lent_auto [ i ]  ) %></td>
<%
		}
%>
</tr>
<% 
		}

	} catch ( Exception e ) {
	
		e.printStackTrace();
	}
%>
</table>
</body>