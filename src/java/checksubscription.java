/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Kehao Xu
 */
public class checksubscription extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String connectionURL = "jdbc:derby://localhost:1527/kex3";
        HttpSession session = request.getSession(); 
        String userid = (String) session.getAttribute("username");
        String html = "";
        try 
        {
            Connection conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            String getRecord = "select * from preorderinfo_room where state='subscribed' and  memberid='"+userid+"'";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(getRecord);
            html = getHtml(rs,session);
            rs.close();
            st.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
        response.getWriter().print(html);
    }
    
    private String getHtml(ResultSet rs, HttpSession session) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        List<Integer> orderids = new ArrayList<Integer>();
        while(rs.next())
        {
            orderids.add(rs.getInt(1));
            
            sb.append("<tr><td>");
            sb.append("<input type=\"checkbox\" class=\"check\"/>");
            sb.append("</td><td>");
            sb.append(rs.getString(2));
            sb.append("</td><td>");
            sb.append(rs.getDate(3).toString());
            sb.append("</td><td>");
            sb.append(rs.getDate(4).toString());
            sb.append("</td><td>");
            sb.append(rs.getString(5));
            sb.append("</td><td>");
            sb.append(rs.getString(6));
            sb.append("</td></tr>");
        }
        if(!sb.toString().isEmpty())
        {
            sb.insert(0, "<table id=\"subscription\"><tr><th>pay</th><th>room number</th><th>start date</th><th>end date</th><th>name</th><th>phone number</th></tr>");
            sb.append("</table>");
            session.setAttribute("subscription", orderids);
        }
        return sb.toString();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
