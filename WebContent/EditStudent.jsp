<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.sis.models.*"%>
<%@page import="com.sis.hibernate.*"%>
<%@page import="java.util.List"%>
<%@page import="com.sis.helpers.*"%>

<!DOCTYPE >
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<br>
	<div class="container-fluid">
		<div class="panel panel-success">
			<div class="panel-heading" align="center">
				<button type="button" class="btn btn-success" style="float: right;">
					<a href="LogoutServlet">Излез</a>
				</button>
				<button type="button" style="float: left;" class="btn btn-success">
					<a href="Info.jsp">Назад</a>
				</button>
				<h4>
					<b><font color="black" style="font-family: fantasy;">Лични
							данни</font> </b>
				</h4>
				<%
				    Integer studentId = Integer.valueOf(request.getParameter("stId"));
				    User user = (User) request.getSession().getAttribute("currentSessionUser");
				    Student studentRecord = DBConnection.getEMF().createEntityManager().find(Student.class, studentId);
				    List<Subject> subjects = (List<Subject>) request.getSession().getAttribute("subjects");
				%>
				<h4>
					<b><font color="black" style="font-family: fantasy;">Студент:
							<%=studentRecord.getFacultyNumber()%></font> </b>
				</h4>
			</div>
			<div class="panel-body" align="center">

				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">

					<div class="panel panel-success" style="max-width: 35%;"
						align="left">

						<div class="panel-heading form-group">
							<b><font color="white"> Студент</font> </b>
						</div>

						<div class="panel-body">

							<form action="UpdateStudentServlet" method="POST">
								<input type="hidden" name="stId"
									value="<%=studentRecord.getId()%>" /> <input type="hidden"
									name="un" value="<%=user.getName()%>" />

								<div class="form-group">
									<label for="fName">Лично име:</label> <input type="text"
										class="form-control" name="fName" required="required"
										value="<%=studentRecord.getFisrtName()%>">

								</div>
								<div class="form-group">
									<label for="lName">Фамилия:</label> <input type="text"
										class="form-control" name="lName" required="required"
										value="<%=studentRecord.getLastName()%>">
								</div>

								<div class="form-group">
									<label for="fNumber">Факултетен номер:</label> <input
										type="text" class="form-control" name="fNumber"
										value="<%=studentRecord.getFacultyNumber()%>">
								</div>

								<div class="form-group">
									<label for="EGN">ЕГН:</label> <input type="text"
										class="form-control" name="EGN"
										value="<%=studentRecord.getEGN()%>">
								</div>

								<div class="form-group">
									<label for="semester">Семестър:</label> <input type="number"
										min="1" max="8" class="form-control" name="semester"
										required="required" value="<%=studentRecord.getSemester()%>">
								</div>
								<button type="submit" style="width: 100%; font-size: 1.1em;"
									class="btn btn-large btn btn-success btn-lg btn-block"
									value="submit">
									<b>Промени</b>
								</button>

							</form>

						</div>
					</div>

				</div>

			</div>
		</div>
	</div>
</body>
</html>