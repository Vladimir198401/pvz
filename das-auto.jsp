<!DOCTYPE html>
<%@page pageEncoding="UTF-8" language="java"%>
<%@page contentType="text/html;charset=UTF-8"%>
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
	String[] lent_auto  = { "id_auto", "modelis", "metai", "rida" , "spalva"};
	String[] lauk_auto = new String [ lent_auto.length ];
%>
<html>
<%
	Connection connection = null;
	Statement statement_take = null;
	Statement statement_change = null;
	ResultSet resultSet = null;
	int resultSetChange;

%>
	<head>
<%	
	String id_auto;
	try{
	     
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");		
		
	} catch(Exception e) {}
%>
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
<%
	try { 
	
		connection = DriverManager.getConnection ( connectionUrl + dbName + "?useUnicode=yes&characterEncoding=UTF-8", userId, password );
		String add; 
		
		if ( ( ( add = request.getParameter("add")  ) != null ) && add.equals ( "papildyti" ) ) {
		
			for ( int i = 1; i<lent_auto.length; i++ ) {
			
				lauk_auto [ i ] = request.getParameter ( lent_auto [ i ] );
			}
			id_auto = request.getParameter( "id_auto" );
			String comma = "";
			
			if  (  id_auto.equals ( "0" ) ) {
				
				String sql_ins = "";
			
				for ( int i = 1; i < lent_auto.length; i++ ) {
				
					sql_ins +=  comma  + "'" + lauk_auto [ i ] + "'";
					comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
				}
				
				sql_ins = 
					"INSERT INTO `das_auto`"
					+ " ( `modelis`, `metai`, `rida` , `spalva`)"
					+ " VALUES ( "			
					+ sql_ins
					+ " )";

				out.println ( sql_ins );

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate(sql_ins);			
			
		 } else {
				String sql_upd = " UPDATE `das_auto` SET\n";				
				
				for ( int i = 1; i < lent_auto.length; i++ ) {
				
					sql_upd += comma  + "`" + lent_auto [ i ]  + "`='" + lauk_auto [ i ] + "'\n";
					comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
				}
				sql_upd += "WHERE `id`=" + id_auto;
				
				out.println ( sql_upd );

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate( sql_upd );
			}
		 } else {
		 
			if ( add != null ) {

				out.println ( add );
			}
		 }
		 
	}  catch ( Exception e ) {
	
		e.printStackTrace();
	}
%>
		<script>
		function iValyma(){
<%			for ( int i=1; i<lent_auto.length; i++ ) {
%>
				document.getElementById( '<%= lent_auto [ i ]  %>' ).value = "";
<%
			}
%>
		}
		function iRedagavima ( id_rec ) {
			
				if ( mygtukas = document.getElementById ( 'toEdit_' + id_rec ) ) {
<%
					for ( int i=1; i<lent_auto.length; i++ ) {
%>					
																																					
						document.getElementById( '<%= lent_auto [ i ]  %>' ).value =  mygtukas.dataset.<%= lent_auto [ i ]  %>;
<%	
					}
%>
					document.getElementById ( "id_auto" ).value = id_rec;
				}
			}
			
			function iTrinima ( id_rec ) {
			
				mygtukasEdit = document.getElementById ( 'toEdit_' + id_rec );

				modelis =  mygtukasEdit.dataset.modelis;
				
				var r = confirm( "Ar norite pašalinti masina " + modelis + "?" );
		
				if ( r == true ) {
					document.getElementById ( "m_del" ).value = id_rec
					forma_del = document.getElementById ( "del_rec" );
					forma_del.submit();
				}
			}
<%		
	try {
		String del;	
	
		if ( ( ( del = request.getParameter("del")  ) != null ) && del.equals ( "del1rec" ) ) {
%>
<%
			id_auto = request.getParameter( "m_del" );
		
			String sql_fkey ="SELECT "
					+ " `id_auto` "
				+ " FROM" 
					+ " `klientu_auto` "  
				+ " WHERE "
					+ "`id_auto` =" + id_auto;
			Statement statement_check = connection.createStatement();					
			resultSet = statement_check.executeQuery(sql_fkey);
		
			
			if ( resultSet.next() ) {
%>			
				alert ( "ups " );
<%				
			} else {
			
				String sql_delete ="DELETE"

						+ " FROM" 
							+ " `das_auto`" ;
				sql_delete += " WHERE `id`=" + id_auto;

				// out.println ( sql_delete );

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate(sql_delete);
			}
			
		} /* else {
		 
			if ( del != null ) {

				out.println ( del );
			}
		 } */
		 
	}  catch ( Exception e ) {
	
		e.printStackTrace();
	}
%>					
		</script>
		
	</head>
<body>
<h2 align="center"><strong>Retrieve data from database in jsp</strong></h2>
<form method="post" action="">
	<table>
		<tr>
			<th>Modelis</th>
			<td>
				<input id = "modelis" type="text" name="modelis" required>
			</td>
		</tr>
		<tr>
			<th>Metai</th>
			<td>
				<input id ="metai" type="number" name="metai" value="2010">
			</td>
		</tr>
		<tr>
			<th>Rida</th>
			<td>
				<input id = "rida" type="number" name="rida" value="100000">
			</td>
		</tr>
		<tr>
			<th>spalva</th>
			<td>
				<input id = "spalva" type="text" name="spalva" required>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			 
				<input type="button" name="clear" value="valyti" onClick = "iValyma()"> 
				<input type="submit" name="add" value="papildyti">
			</td>
		</tr>
	</table>
		<input type="hidden" id="id_auto" name="id_auto" value="0">
</form>
<form id="del_rec" method="post" action="">
	<input type="hidden" name="del" value="del1rec">
	<input type="hidden" id="m_del" name="m_del" value="0">
</form>
<table align="center">
<tr>
</tr>
<tr>
	<th>id</th>
	<th>Veiksmai</th>
	<th>Modelis</th>
	<th>Metai</th>
	<th>Rida</th>
	<th>spalva</th>
</tr>
		
<%
	try {
	
		statement_take = connection.createStatement();		
		String sql ="SELECT "
					+ "*"
				+ "FROM" 
					+ "`das_auto`"  
				+ "WHERE"
					+ "1";

		resultSet = statement_take.executeQuery(sql);
		

		 
		while( resultSet.next() ){
		
			String rec_data = "";
		
			for ( int i = 1; i < lauk_auto.length; i++ ) {

				rec_data += " data-"  + lent_auto [ i ]  + "=\"" + resultSet.getString (  lent_auto [ i ]  ) + "\"";

			}
			String id_rec = resultSet.getString (  "id"  );
%>

<tr>
	<td><input type="button" class="record_edit"  id="toEdit_<%= id_rec  %>" data-id_auto="<%= id_rec  %>"<%= rec_data %> value="&#9998;" onClick="iRedagavima( <%= id_rec %> )"></td>
	<td><input type="button" class="delete"  id="toDelete_<%= id_rec  %>" data-id_auto="<%= id_rec %>" value="&#10007;" onClick="iTrinima( <%= id_rec %> )"></td>
	
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