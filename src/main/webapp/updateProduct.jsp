<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.sougata.service.impl.*, com.sougata.service.*,com.sougata.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Product</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #E6F9E6;">
	<%
	/* Checking the user credentials */
	String utype = (String) session.getAttribute("usertype");
	String uname = (String) session.getAttribute("username");
	String pwd = (String) session.getAttribute("password");
	String prodid = request.getParameter("prodid");
	ProductBean product = new ProductServiceImpl().getProductDetails(prodid);
	if (prodid == null || product == null) {
		response.sendRedirect("updateProductById.jsp?message=Please Enter a valid product Id");
		return;
	} else if (utype == null || !utype.equals("admin")) {
		response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
		return;
	} else if (uname == null || pwd == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
		return;
	}
	%>

	<jsp:include page="header.jsp" />

	<%
	String message = request.getParameter("message");
	%>
	<div class="container">
		<div class="row"
			style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
			<form action="./UpdateProductSrv" method="post"
				class="col-md-6 col-md-offset-3"
				style="border: 2px solid black; border-radius: 10px; background-color: #FFE5CC; padding: 10px;">
				<div style="font-weight: bold;" class="text-center">
					<div class="form-group">
						<img src="./ShowImage?pid=<%=product.getProdId()%>"
							alt="Product Image" height="100px" />
						<h2 style="color: green;">Product Update Form</h2>
					</div>

					<%
					if (message != null) {
					%>
					<p style="color: blue;">
						<%=message%>
					</p>
					<%
					}
					%>
				</div>
				<div class="row">
					<input type="hidden" name="pid" class="form-control"
						value="<%=product.getProdId()%>" id="last_name" required>
				</div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="last_name">Product Name</label> <input type="text"
							placeholder="Enter Product Name" name="name" class="form-control"
							value="<%=product.getProdName()%>" id="last_name" required>
					</div>
					<div class="col-md-6 form-group">
						<%
						String ptype = product.getProdType();
						%>
						<label for="producttype">Product Type</label> <select name="type"
							id="producttype" class="form-control" required>
							<option value="photoFrame"
								<%="photoFrame".equalsIgnoreCase(ptype) ? "selected" : ""%>>Photo Frame</option>
							<option value="painting"
								<%="painting".equalsIgnoreCase(ptype) ? "selected" : ""%>>Painting</option>
							<option value="cards"
								<%="cards".equalsIgnoreCase(ptype) ? "selected" : ""%>>Cards</option>
							<option value="wallHanging"
								<%="wallHanging".equalsIgnoreCase(ptype) ? "selected" : ""%>>Wall Hanging</option>
							<option value="sheet"
								<%="sheet".equalsIgnoreCase(ptype) ? "selected" : ""%>>Sheet</option>
							<option value="designedBedSheet"
								<%="designedBedSheet".equalsIgnoreCase(ptype) ? "selected" : ""%>>Designed Bed Sheet</option>
							<option value="basket"
								<%="basket".equalsIgnoreCase(ptype) ? "selected" : ""%>>Basket</option>
							<option value="fan"
								<%="fan".equalsIgnoreCase(ptype) ? "selected" : ""%>>Fan</option>
							<option value="bag"
								<%="bag".equalsIgnoreCase(ptype) ? "selected" : ""%>>Bag</option>
							<option value="sweater"
								<%="sweater".equalsIgnoreCase(ptype) ? "selected" : ""%>>Sweater</option>
							<option value="mat"
								<%="mat".equalsIgnoreCase(ptype) ? "selected" : ""%>>Mat</option>
							<option value="doorMat"
								<%="doorMat".equalsIgnoreCase(ptype) ? "selected" : ""%>>Door Mat</option>
							<option value="diary"
								<%="diary".equalsIgnoreCase(ptype) ? "selected" : ""%>>Diary</option>
							<option value="flower"
								<%="flower".equalsIgnoreCase(ptype) ? "selected" : ""%>>Flower</option>
							<option value="flowerVase"
								<%="flowerVase".equalsIgnoreCase(ptype) ? "selected" : ""%>>Flower Vase</option>
							<option value="kite"
								<%="kite".equalsIgnoreCase(ptype) ? "selected" : ""%>>Kite</option>
							<option value="fishingNet"
								<%="fishingNet".equalsIgnoreCase(ptype) ? "selected" : ""%>>Fishing Net</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="last_name">Product Description</label>
					<textarea name="info" class="form-control text-align-left"
						id="last_name" required><%=product.getProdInfo()%></textarea>
				</div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="last_name">Unit Price</label> <input type="number"
							value="<%=product.getProdPrice()%>"
							placeholder="Enter Unit Price" name="price" class="form-control"
							id="last_name" required>
					</div>
					<div class="col-md-6 form-group">
						<label for="last_name">Stock Quantity</label> <input type="number"
							value="<%=product.getProdQuantity()%>"
							placeholder="Enter Stock Quantity" class="form-control"
							id="last_name" name="quantity" required>
					</div>
				</div>
				<div class="row text-center">
					<div class="col-md-4" style="margin-bottom: 2px;">
						<button formaction="adminViewProduct.jsp" class="btn btn-danger">Cancel</button>
					</div>
					<div class="col-md-4">
						<button type="submit" class="btn btn-success">Update
							Product</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>