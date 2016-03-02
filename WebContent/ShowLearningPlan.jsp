<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.sis.models.*"%>
<%@page import="com.sis.hibernate.*"%>
<%@page import="com.sis.helpers.*"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Show Learning Plan</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="bootstrap/js/bootstrap.js"></script>
<script src="WbContent/js/MyToggle.js"></script>
</head>
<body>
	<%
	    EntityManagerFactory emf = DBConnection.getEMF();
	    List<Subject> subjects = (List<Subject>) Finder.findAll(emf.createEntityManager(), Subject.class);
	    User user = (User) request.getSession().getAttribute("currentSessionUser");
	    Student studentRecord = user.getStudent();
	%>
	<br>
	<div class="container-fluid">
		<div class="panel panel-success">
			<div class="panel-heading" align="center">

				<div id='cssmenu'>
					<ul>
						<li><a href="Info.jsp">Информация</a></li>
						<li><a
							href="ShowGradesServlet?stId=<%=studentRecord.getId()%>">Оценки</a></li>
						<li class="active"><a href="#">Учебен план</a></li>
						<li style="float: right;"><a href="LogoutServlet">Излез</a></li>
					</ul>
				</div>
			</div>

		</div>

		<div class="panel-body" align="center">

			<div class="container " style="margin-top: 10%; margin-bottom: 10%;">

				<div class="panel panel-success" style="max-width: 100%;"
					align="left">

					<table class="table table-striped">
						<thead>
							<td>#</td>
							<td>Дисциплина</td>
							<td>Форма на контрол</td>
						</thead>
						<tbody>

							<tr align="center" nowrap="nowrap" colspan="5" class="success">
								<td></td>
								<td>Семестър 1</td>
								<td></td>
							</tr>


							<%
							    for (Subject s : subjects) {
							%>
							<%
							    if (s.getSemester() > 1 && s.getSemester() > (subjects.get(s.getId() - 2)).getSemester()) {
							%>

							<tr align="center" nowrap="nowrap" colspan="5" class="success">
								<td></td>
								<td>Семестър <%=s.getSemester()%></td>
								<td></td>
							</tr>
							<%
							    }
							%><tr>
								<td><%=subjects.indexOf(s) + 1%></td>
								<td><%=s.getName()%></td>
								<%
								    if (s.getFormOfControl().isEmpty()) {
								%>
								<td>Няма</td>
								<%
								    } else {
								%>
								<td><%=s.getFormOfControl()%></td>
								<%
								    }
								    }
								%>
							</tr>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

		</div>

	</div>
	</div>
	</div>
</body>
</html>