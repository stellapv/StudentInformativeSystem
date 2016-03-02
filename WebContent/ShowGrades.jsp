<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.sis.models.*"%>
<%@page import="com.sis.hibernate.*"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Show Grades</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%
	    EntityManagerFactory emf = DBConnection.getEMF();

	    Student studentRecord = null;
	    List<Subject> subjects = null;
	    Integer studentId = Integer.valueOf(request.getParameter("stId"));
	    User user = (User) request.getSession().getAttribute("currentSessionUser");
	    if (user.isAdmin()) {

	        studentRecord = DBConnection.getEMF().createEntityManager().find(Student.class, studentId);
	        subjects = (List<Subject>) studentRecord.getSubjectsUntilCurrentSemester(emf.createEntityManager());
	    } else {
	        studentRecord = user.getStudent();
	        subjects = (List<Subject>) request.getSession().getAttribute("subjects");
	    }
	%>
	<br>
	<div class="container-fluid">
		<div class="panel panel-success">
			<div class="panel-heading" align="center">
				<%
				    if (!user.isAdmin()) {
				%>
				<div id='cssmenu'>
					<ul>
						<li><a href="Info.jsp">Информация</a></li>
						<li class='active'><a
							href="ShowGradesServlet?stId=<%=studentRecord.getId()%>">Оценки</a></li>
						<li><a href="ShowLearningPlan.jsp">Учебен план</a></li>
						<li style="float: right;"><a href="LogoutServlet">Излез</a></li>
					</ul>
					<%
					    }
					    if (user.isAdmin()) {
					%>
					<button type="button" style="float: left;" class="btn btn-success">
						<a href="Info.jsp">Назад</a>
					</button>
					<button type="button" class="btn btn-success" style="float: right;">
						<a href="LogoutServlet">Излез</a>
					</button>
					<h4>
						<b><font color="black"
							style="font-family: fantasy; text-align: center;">Оценки</font> </b>
					</h4>

					<h4>
						<b><font color="black" style="font-family: fantasy;">Студент:
								<%=studentRecord.getFacultyNumber()%></font> </b>
					</h4>
					<%
					    }
					%>
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
							<td>Оценка</td>
						</thead>
						<tbody>

							<tr align="center" nowrap="nowrap" colspan="5" class="success">
								<td></td>
								<td>Семестър 1</td>
								<td></td>
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
								<td></td>
							</tr>
							<%
							    }
							%><tr>
								<td><%=subjects.indexOf(s) + 1%></td>
								<td><%=s.getName()%></td>
								<%
								    Grade mark = s.getSubjectGrade(DBConnection.getEMF().createEntityManager(), studentRecord);

								        if (s.getFormOfControl().isEmpty()) {
								%>
								<td>Няма</td>
								<%
								    } else {
								%>
								<td><%=s.getFormOfControl()%></td>
								<%
								    }
								        if (s.getFormOfControl().isEmpty()) {
								%><td>-</td>
								<%
								    } else if (mark == null) {
								%>
								<td>Неположен</td>
								<%
								    } else {
								%>
								<td><%=mark.getMark()%></td>
								<%
								    }
								        if (user.isAdmin() && !s.getFormOfControl().isEmpty()) {
								%>

								<td><a
									href="EditGrade.jsp?sbId=<%=s.getId()%>&stId=<%=studentId%>">Редактирай
										оценка</a></td>
								<%
								    } else if (user.isAdmin()) {
								%>
								<td>-</td>
								<%
								    }
								%>
								</td>

							</tr>
							<%
							    }
							%>
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