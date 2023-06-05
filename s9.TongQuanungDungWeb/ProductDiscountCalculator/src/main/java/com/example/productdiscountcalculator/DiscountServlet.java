package com.example.productdiscountcalculator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

@WebServlet(name = "DiscountServlet", value = "/calculator")
public class DiscountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("index.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String description = req.getParameter("product-description");
        double price=Double.parseDouble(req.getParameter("product-price"));
        float percent = Float.parseFloat(req.getParameter("product-percent"));
        double amount = price * percent * 0.01;
        double discount_price = price - amount;
        PrintWriter writer = resp.getWriter();
        writer.println("<html>");

        String product_description= URLDecoder.decode(description,"UTF-8");

        writer.println("<h1>Product Description: " + product_description + "</h1>");
        writer.println("<h3>Discount Amount: " + amount +"</h3>");
        writer.println("<h3>Discount Price: " + discount_price + "</h3>");

        writer.println("</html>");
    }
}
