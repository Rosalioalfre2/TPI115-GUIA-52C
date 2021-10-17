<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Actualizar, Eliminar, Crear registros.</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="stylesheet" href="css/libros.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script> 
 </head>
 <body class="container" background="libros.jpg">
 <div class="row">
 <div class="col-md-1">
 </div>
<div class="card col-lg-12" style="background-color: rgba(245, 245, 245, 0.8)">
<div class="card-header text-center">
<H1>MANTENIMIENTO DE LIBROS</H1>
</div>
<div class="card-body">
<form action="matto.jsp" method="post" name="Actualizar">
   <table>
      
      <tr>
         <td>
            <h2>Gestionar libros</h2>
         </td>
      </tr>

      <tr><td><div class="tituloDeCaja">ISBN</div>  <input class="form-control" type="text" name="isbn" id="is1"  size="40" placeholder="Ingrese ISBN" required/></td></tr>
     
      <tr><td><div class="tituloDeCaja">Titulo</div> <input class="form-control" type="text" name="titulo" id="t1"  size="50" placeholder="Ingrese t&iacute;tulo" required/></td></tr>
    
      <tr><td><div class="tituloDeCaja">Autor</div> <input class="form-control" type="text" name="autor" id="a1"  size="50" placeholder="Ingrese autor" required/></td></tr>
   
      <tr><td><div class="tituloDeCaja">A&ntilde;o de publicaci&oacute;n</div> <input class="form-control" type="text" name="anio" id="anio1"  size="4" placeholder="A&ntilde;o" required/></td></tr>
      <tr>
         <td>
            <div class="tituloDeCaja">Editorial</div>
            <%
               ServletContext context_edi=request.getServletContext();
               String path_edi=context_edi.getRealPath("/data");
               Connection conexion_edi=getConnection(path_edi);
               if(!conexion_edi.isClosed()){
                  out.write("");
                  Statement a=conexion_edi.createStatement();
                  ResultSet b=a.executeQuery("select * from editorial");
                  
                  //Los resultados se muestran en una lista html
                  out.println("<select class='form-control' id=\"editorial1\" name='editorial'>");
                  out.println("<option>Seleccionar editorial</option>");

                  while(b.next()){
                     out.println("<option>"+b.getString("nombre")+"</option>");
                  }
                  out.println("</select><br>");   
               }
            %>
         </td>
      </tr>
      <tr>
         <td>
            <div id="tablaConDobleColumna">
               <table>
                  <tr>
                     <td>
                        <h5>Seleccionar accion</h5> 
                        <input type="radio" name="Action" id="update" value="Actualizar" /> Actualizar
                        <input type="radio" name="Action" id= "delete" value="Eliminar" /> Eliminar
                        <input type="radio" name="Action" id="new" value="Crear" checked /> Crear
                     </td>
                     <td>
                        <input id="btnAceptar" class="form-control btn btn-success" type="SUBMIT" value="ACEPTAR" />  
                     </td>
                  </tr>
               </table>
            </div>
         </td>
      </tr>       
   </table>
</form>
</div>
<br>
<br>
<div id="formBuscar">
   <h3>Buscar libro o autor</h3>
   <form name="formbusca" action="libros.jsp" method="POST">
      <table>
         <tr>
            <td>Titulo a buscar: <input class="form-control" type="text" id="bt" name="buscartitulo" placeholder="Ingrese un titulo"></td>
         </tr>
         <tr>
            <td>
               Autor a buscar: <input class="form-control" type="text" id="ba" name="buscarautor" placeholder="Ingrese un autor">
            </td>
         </tr>      
         <tr>
            <td>
               <br>
               
                  <button class="form-control btn btn-success" type="button" id="filtro" onclick="filtrar()">BUSCAR</button>
           
            </td>
         </tr>
      </table>
   </form>
   <br>
</div>

   
   <div id="contenidoTabla">
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
   
   ServletContext context=request.getServletContext();
   String path=context.getRealPath("/data");
   Connection conexion = getConnection(path);
   
      if (!conexion.isClosed()){
   out.write("<br>\n<h2>Listado de libros</h2>");
    
         Statement st = conexion.createStatement();
         ResultSet rs = st.executeQuery("select * from libros" );
     
         // Ponemos los resultados en un table de html                                 
         out.println("<br>");
         out.println("<table id='tablaDeContenido' class='table table-striped table-bordered bg-light'  border=\"1\" id='tabla1'><tr><td>Num.</td><td>ISBN</td><td><a href='#' onclick='ordenar(2)'>Titulo</a></td><td>Autor</td><td>A&ntilde;o</td><td>Editorial</td><td>Accion</td></tr>");
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
            out.println("<td>"+"<a class='form-control btn-primary text-center' href=\'#!\' id='"+i+"' onclick='actualizar(this);'>"+"Actualizar</a>"+"<br>"+"<a class='form-control btn-danger text-center' href='matto.jsp?num="+ i +"&isbn="+isbn+"&titulo="+titulo+"&Action=Eliminar'>"+" Eliminar "+"</a>"+"</td>");
            out.println("</tr>");
            i++;
         }  
         
         out.println("</table>");
   
         // cierre de la conexion
         conexion.close();
   }
   %>
   </div>
<br/>
<div class="custom">
   Zona de descargas
</div>
<table align="center">
   <tr>
      <td>
         <a class="btn-secondary form-control text-center" href="listado-csv.jsp" download=�libros.csv�>DESCARGAR CSV</a>
      </td>
      <td>
         <a class="btn-secondary form-control text-center" href="listado-txt.jsp" download=�libros.txt�>DESCARGAR TXT</a>
      </td>
      <td>
         <a class="btn-secondary form-control text-center" href="listado-xml.jsp" download=�libros.xml�>DESCARGAR XML</a>
      </td>
      <td>
         <a class="btn-secondary form-control text-center" href="lista-json.jsp" download=�libros.json�>DESCARGAR JSON</a>
      </td>
   </tr>
</table>
<script src="js/libros.js"></script>
<div class="footer">
   Todos los derechos reservados GP06 - TPI115 - 2021 <br>
   Universidad de El Salvador
</div>
</div>
</div>
<div class="col-md-1">
</div>
</div>
</body>