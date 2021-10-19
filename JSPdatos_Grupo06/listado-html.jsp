<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
 
<%

 
/* Inicializar variables */
String ls_result = "Base de datos actualizada...";
String ls_query = "";
ServletContext context= request.getServletContext();
String path = context.getRealPath("/data");
String filePath= path+"\\datos.mdb";
String ls_dburl = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;
String ls_usuario = "";
String ls_password = "";
String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";

 
/* Conexi�n a la base de datos */
Connection l_dbconn = null;
 
try {
Class.forName(ls_dbdriver);
/*&nbsp; getConnection(URL,User,Pw) */
l_dbconn = DriverManager.getConnection(ls_dburl,ls_usuario,ls_password);
 
/*Creaci�n de SQL Statement */
Statement l_statement = l_dbconn.createStatement();
/* Ejecuci�n de SQL Statement */
l_statement.execute(ls_query);
} catch (ClassNotFoundException e) {
ls_result = " Error creando el driver!";
ls_result += " <br/>" + e.toString();
} catch (SQLException e) {
ls_result = " Error procesando el SQL!";
ls_result += " <br/>" + e.toString();
} finally {
/* Cerramos */
try {
if (l_dbconn != null) {
l_dbconn.close();
}
} catch (SQLException e) {
ls_result = "Error al cerrar la conexi�n.";
ls_result += " <br/>" + e.toString();
}
}
%>


<%!
public Connection getConnection(String path) throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath= path+"\\datos.mdb";
String userName="",password="";
String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
System.out.println("Error: " + e);
 }
    return conn;
}
%>
<%

response.setStatus(200);
response.setHeader ("content-type ", "application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment;filename=listado.html");


Connection conexion = getConnection(path);

   if (!conexion.isClosed()){
    out.write("<br>\n<h2>Listado de libros</h2>");
    
    Statement st = conexion.createStatement();
    ResultSet rs = st.executeQuery("select * from libros" );

    // Ponemos los resultados en un table de html                                 
    out.println("<br>");
    out.println("<table id='tablaDeContenido' class='table table-striped table-bordered bg-light'  border=\"1\" id='tabla1'><tr><td>Num.</td><td>ISBN</td><td><a href='#' onclick='ordenar(2)'>Titulo</a></td><td>Autor</td><td>A&ntilde;o</td><td>Editorial</td></tr>");
    int i=1;
    String isbn, titulo, autor, anio, edit;
    
    while (rs.next())
    {
       out.println("<tr>");
       out.println("<td>"+ i +"</td>");
       isbn=rs.getString("isbn");
       titulo=rs.getString("titulo");
       autor=rs.getString("autor");
       anio=rs.getString("anio");
       edit=rs.getString("editorial");
       out.println("<td id='i"+i+"'>"+isbn+"</td>");
       out.println("<td id='t"+i+"'>"+titulo+"</td>");
       out.println("<td id='a"+i+"'>"+autor+"</td>");
       out.println("<td id='an"+i+"'>"+anio+"</td>");
       out.println("<td id='ed"+i+"'>"+edit+"</td>");
       out.println("</tr>");
       i++;
    }  
    
    out.println("</table>");

    // cierre de la conexion
    conexion.close();
}

%>