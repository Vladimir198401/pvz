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
	String[] lent_auto  = { "id_klientu_auto", "vardas", "pavarde", "tel_nr","modelis","metai","rida" };
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
	String id_klientu_auto;
	try{
	     
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");		
		
	} catch(Exception e) {}
	
		//String id_klientu_auto;
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
			.autos {
				margin-right: 7px;
				margin-left: 7px;
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
			id_klientu_auto = request.getParameter( "id_klientu_auto" );
			String comma = "";
			
			if  (  id_klientu_auto.equals ( "0" ) ) {
				
				String sql_ins = "";
			
				for ( int i = 1; i < lent_auto.length; i++ ) {
				
					sql_ins +=  comma  + "'" + lauk_auto [ i ] + "'";
					comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
				}
				
				sql_ins = 
					"INSERT INTO `klientu_auto`"
					+ " ( `vardas`, `pavarde`, `tel_nr`,`modelis`,`metai`,`rida`)"
					+ " VALUES ( "			
					+ sql_ins
					+ " )";

				out.println ( sql_ins );

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate(sql_ins);			
			
			} else {
					String sql_upd = " UPDATE `klientu_auto` SET\n";				
					
					for ( int i = 1; i < lent_auto.length; i++ ) {
					
						sql_upd += comma  + "`" + lent_auto [ i ]  + "`='" + lauk_auto [ i ] + "'\n";
						comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
					}
					sql_upd += "WHERE `id`=" + id_klientu_auto;
					
					//out.println ( sql_upd );

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
		function iRedagavima ( id_rec ) {
			
				if ( mygtukas = document.getElementById ( 'toEdit_' + id_rec ) ) {
<%
					for ( int i=1; i<lent_auto.length; i++ ) {
					
%>					
																																					
						document.getElementById( '<%= lent_auto [ i ]  %>' ).value =  mygtukas.dataset.<%= lent_auto [ i ]  %>;
<%	
					}
%>
					document.getElementById ( "id_klientu_auto" ).value = id_rec;
				}
			}
			
			function iTrinima ( id_rec ) {
			
				mygtukasEdit = document.getElementById ( 'toEdit_' + id_rec );

				vardas =  mygtukasEdit.dataset.vardas;
				
				var r = confirm( "Ar norite pašalinti masina " + vardas + "?" );
		
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
			id_klientu_auto = request.getParameter( "m_del" );
		
			String sql_fkey ="SELECT "
					+ " `id_klientu_auto` "
				+ " FROM" 
					+ " `klientu_auto` "  
				+ " WHERE "
					+ "`id_klientu_auto` =" + id_klientu_auto;
			Statement statement_check = connection.createStatement();					
			resultSet = statement_check.executeQuery(sql_fkey);
		
			if ( resultSet.next() ) {
%>			
				alert ( "ups " );
<%				
			} else {
			
				String sql_delete ="DELETE"

						+ " FROM" 
							+ " `klientu_auto`" ;
				sql_delete += " WHERE `id`=" + id_klientu_auto;

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate(sql_delete);
			}
			
		} 
		
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
			<th>vardas</th>
			<td>
				<input id = "vardas" type="text" name="vardas" required>
			</td>
		</tr>
		<tr>
			<th>pavarde</th>
			<td>
				<input id ="pavarde" type="text" name="pavarde" value="pavarde">
			</td>
		</tr>
		<tr>
			<th>tel_nr</th>
			<td>
				<input id = "tel_nr" type="number" name="tel_nr" value="100000">
			</td>
		</tr>
		<tr>
			<th>modelis</th>
			<td>
				<input id ="modelis" type="text" name="modelis" required>
			</td>
		</tr>
		<tr>
			<th>metai</th>
			<td>
				<input id ="metai" type="text" name="metai" value="2000">
			</td>
		</tr>
		<tr>
			<th>rida</th>
			<td>
				<input id ="rida" type="text" name="rida" required>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			 
				<input type="button" name="clear" value="valyti" onClick = "iValyma()"> 
				<input type="submit" name="add" value="papildyti">
			</td>
		</tr>
	</table>
		<input type="hidden" id="id_klientu_auto" name="id_klientu_auto" value="0">
</form>
<form id="del_rec" method="post" action="">
	<input type="hidden" name="del" value="del1rec">
	<input type="hidden" id="m_del" name="m_del" value="0">
</form>	
		<table align="center">
<tbody><tr>
</tr>
<tr>

	<!-- th>Funkcijos</th>
	<th>id</th --> 
	<th>vardas</th>
	<th>pavarde</th>
	<th>tel_nr</th>
	<tr></tr>
	<td></td>
	<td></td>
	<td></td>
</tr>
<tr>	
	<td colspan="3"> 
		<table class="autos">
			<tr>
			<th>modelis</th>
			<th>metai</th>
			<th>rida</th>
			<tr></tr>
			<td></td>
			<td></td>
			<td></td>
		</table>
	</td>
</tr>
<%
	try {
	
		statement_take = connection.createStatement();		
		String sql ="SELECT "
					+ "*"
				+ "FROM" 
					+ "`klientu_auto`"  
				+ "LEFT JOIN "
					+ "`klientas` ON ( "
					+ "`klientu_auto`.`id_kliento` = `klientas`.`id` "
					+ ")"
				+ " RIGHT JOIN"
					+ "`das_auto` ON ("
					+"`klientu_auto`.`id_auto` = `das_auto`.`id`"
					+") UNION  ("
					+"SELECT "
					+ "*"
				+ "FROM" 
					+ "`klientu_auto`"  
				+ "RIGHT JOIN "
					+ "`klientas` ON ( "
					+ "`klientu_auto`.`id_kliento` = `klientas`.`id` "
					+ ")"
				+ " LEFT JOIN"
					+ "`das_auto` ON ("
					+"`klientu_auto`.`id_auto` = `das_auto`.`id`"
					+") )"					
				;
					
		resultSet = statement_take.executeQuery(sql);
		

		 
		while( resultSet.next() ){
		
			String rec_data = "";
		
			for ( int i = 1; i < lauk_auto.length; i++ ) {
				rec_data += " data-"  + lent_auto [ i ]  + "=\"" + resultSet.getString (  lent_auto [ i ]  ) + "\"";
			}
			String id_rec = resultSet.getString (  "id"  );

%>

<tr>
	<!--td><input type="button" class="record_edit"  id="toEdit_<%= id_rec  %>" data-id_klientu_auto="<%= id_rec  %>"<%= rec_data %> value="&#9998;" onClick="iRedagavima( <%= id_rec %> )"></td>
	<td><input type="button" class="delete"  id="toDelete_<%= id_rec  %>" data-id_klientu_auto="<%= id_rec %>" value="&#10007;" onClick="iTrinima( <%= id_rec %> )"></td-->
	
<%
		for ( int i = 1; i < lauk_auto.length; i++ ) {
		
		
%>
	<td><%= resultSet.getString (  lent_auto [ i ]  ) %></td >
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