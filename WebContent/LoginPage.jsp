<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
				<h4>
					<b><font color="black" style="font-family: fantasy;">Вход
							в студентската система</font> </b>
				</h4>
			</div>
			<div class="panel-body" align="center">

				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">

					<div class="panel panel-success" style="max-width: 35%;"
						align="left">

						<div class="panel-heading form-group">
							<b><font color="white"> Вход</font> </b>
						</div>

						<div class="panel-body">

							<form action="LoginServlet">
								<div class="form-group">
									<label for="EGN">ЕГН/ЛНЧ:</label> <input type="text"
										class="form-control" name="un" id="un"
										placeholder="Въведи ЕГН/ЛНЧ" required="required">

								</div>
								<div class="form-group">
									<label for="fNumber">Фак. номер:</label> <input type="password"
										class="form-control" name="pw" id="pw"
										placeholder="Фак. номер" required="required">
								</div>
								<button type="submit" style="width: 100%; font-size: 1.1em;"
									class="btn btn-large btn btn-success btn-lg btn-block">
									<b>Влез</b>
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