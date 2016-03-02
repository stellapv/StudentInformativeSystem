<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.sis.models.*"%>
<%@page import="com.sis.hibernate.*"%>
<%@page import="java.util.List"%>
<%@page import="com.sis.helpers.*"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%
	    User user = (User) request.getSession().getAttribute("currentSessionUser");
	    Integer studentId = Integer.valueOf(request.getParameter("stId"));
	    Integer subjectId = Integer.valueOf(request.getParameter("sbId"));
	    Student studentRecord = DBConnection.getEMF().createEntityManager().find(Student.class, studentId);
	    Subject subjectRecord = DBConnection.getEMF().createEntityManager().find(Subject.class, subjectId);
	%>

	<br>
	<div class="container-fluid">
		<div class="panel panel-success">

			<div class="panel-heading" align="center">

				<button type="button" style="float: left;" class="btn btn-success">
					<a href="ShowGrades.jsp?stId=<%=studentId%>">Назад</a>
				</button>
				<button type="button" class="btn btn-success" style="float: right;">
					<a href="LogoutServlet">Излез</a>
				</button>
				<h4>
					<b style="text-align: center"><font color="black"
						align="center" style="font-family: fantasy;">Оценки</font> </b>
				</h4>
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
							<b><font color="white"> Оценки</font> </b>
						</div>

						<div class="panel-body">

							<form action="UpdateGradeServlet" method="POST">
								<input type="hidden" name="stId"
									value="<%=studentRecord.getId()%>" /> <input type="hidden"
									name="sbId" value="<%=subjectRecord.getId()%>" /> <input
									type="hidden" name="un" value="<%=user.getName()%>" />
								<fieldset disabled>
									<div class="form-group">
										<label for="sb">Дисциплина:</label> <input type="text"
											class="form-control" name="sb" label="disabledTextInput"
											value="<%=subjectRecord.getName()%>">

									</div>
									<div class="form-group">
										<label for="formOfControl">Форма на контрол:</label> <input
											type="text" class="form-control" name="formOfControl"
											value="<%=subjectRecord.getFormOfControl()%>">
									</div>
								</fieldset>
								<div class="form-group">
									<label for="mark">Оценка:</label>
									<%
									    if (subjectRecord.getSubjectGrade(DBConnection.getEMF().createEntityManager(), studentRecord) != null) {
									%><input type="number" min="2" max="6" class="form-control"
										name="mark" required="required"
										value="<%=subjectRecord.getSubjectGrade(DBConnection.getEMF().createEntityManager(), studentRecord)
                        .getMark()%>">
									<%
									    } else {
									%>
									<input type="number" min="2" max="6" class="form-control"
										name="mark" value="Неположен" />
									<%
									    }
									%>
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