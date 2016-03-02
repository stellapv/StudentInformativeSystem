<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.sis.models.*"%>
<%@page import="com.sis.hibernate.*"%>
<%@page import="com.sis.helpers.*"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.*"%>
<%@page import="javax.servlet.http.HttpSession.*"%>

<!DOCTYPE>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Info</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<%
	    User user = (User) request.getSession().getAttribute("currentSessionUser");
	    Student studentRecord = user.getStudent();
	%>
	<%
	    List<Student> allStudents = (List<Student>) Finder.findAll(DBConnection.getEMF().createEntityManager(),
	            Student.class);
	%>
	<div class="success">Добре дошли в студентската система!</div>

	<div class="container-fluid">
		<div class="panel panel-success">

			<div class="panel-heading" align="center">
				<%
				    if (!user.isAdmin()) {
				%>
				<div id='cssmenu'>
					<ul>
						<li class='active'><a href="Info.jsp">Информация</a></li>
						<li><a
							href="ShowGradesServlet?stId=<%=studentRecord.getId()%>">Оценки</a></li>
						<li><a href="ShowLearningPlan.jsp">Учебен план</a></li>
						<li style="float: right;"><a href="LogoutServlet">Излез</a></li>
					</ul>
					<%
					    }
					    if (user.isAdmin()) {
					%>
					<button type="button" class="btn btn-success" style="float: right;">
						<a href="LogoutServlet">Излез</a>
					</button>
					<h4>
						<b><font color="black" style="font-family: fantasy;">Студенти</font>
						</b>
					</h4>
					<%
					    }
					%>
				</div>


			</div>

			<div class="panel-body" align="center">

				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">

					<div class="panel panel-success" style="max-width: 100%;"
						align="left">

						<%
						    if (user.isAdmin()) {
						%>
						<table class="table table-striped">
							<thead>
								<td>#</td>
								<td>Име</td>
								<td>Фамилия</td>
								<td>Факултетен номер</td>
								<td>ЕГН</td>
								<td>Семестър</td>
								<td></td>
								<td></td>
							</thead>
							<tbody>
								<tr>
									<%
									    for (Student s : allStudents) {
									%>
									<td><%=allStudents.indexOf(s) + 1%></td>
									<td><%=s.getFisrtName()%></td>
									<td><%=s.getLastName()%></td>
									<td><%=s.getFacultyNumber()%></td>
									<td><%=s.getEGN()%></td>
									<td><%=s.getSemester()%></td>
									<td><a href="EditStudent.jsp?stId=<%=s.getId()%>">Редактирай
											студент</a></td>
									<td><a href="ShowGrades.jsp?stId=<%=s.getId()%>">Покажи
											оценки</a></td>
								</tr>
								<%
								    }
								%>
							</tbody>
						</table>
						<%
						    } else {
						%>

						<div id="container">
							<table class="table table-striped">
								<tbody>
									<tr>
										<td><b>Име</b></td>
										<td><%=studentRecord.getFisrtName()%> <%=studentRecord.getLastName()%></td>
									</tr>
									<tr>
										<td><b>Факултетен номер</b></td>
										<td><%=studentRecord.getFacultyNumber()%></td>

									</tr>
									<tr>
										<td><b>ЕГН</b></td>
										<td><%=studentRecord.getEGN()%></td>
									</tr>
									<tr>
										<td><b>Семестър</b></td>
										<td><%=studentRecord.getSemester()%></td>
									</tr>
								</tbody>
							</table>
							</form>
						</div>
						<%
						    }
						%>
					</div>
				</div>

			</div>

		</div>
	</div>
	</div>
</body>
</html>