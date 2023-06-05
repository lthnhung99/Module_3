<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
    <title>Product Discount Calculator</title>
</head>
<body>
<h2>Product Discount Calculator</h2>
<form action="/calculator" method="post">
    <label>Product Description: </label><br/>
    <input type="text" name="product-description" placeholder="Product Description" value=""/><br/>
    <label>List Price: </label><br/>
    <input type="text" name="product-price" placeholder="20000" value=""/><br/>
    <label>Discount Percent: </label><br/>
    <input type="text" name="product-percent" placeholder="%" value=""/><br/><br/>
    <input type = "submit" id = "submit" value = "Result"/>
</form>
</body>
</html>