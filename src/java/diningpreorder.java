/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Kehao Xu
 */
public class diningpreorder extends HttpServlet {



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
        
        String name = request.getParameter("name");
        String phonenumber = request.getParameter("phonenumber");
        String connectionURL = "jdbc:derby://localhost:1527/kex3";
        String state = "fail";
        HttpSession session = request.getSession(); 
        String type =(String) session.getAttribute("type_dining");
        Date startdate = (Date) session.getAttribute("startdate_dining");
        Time time = (Time) session.getAttribute("time_dining");
        String number = (String) session.getAttribute("number_dining");
        try 
        {
            Connection conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            String findlast = "select orderid from preorderinfo_dining order by orderid desc";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(findlast);
            int last = 1;
            if(rs.next())
            {
                last = rs.getInt(1);
                last = last + 1;
            }
            String sql = "insert into preorderinfo_dining VALUES("+last+","+number+",'"+startdate.toString()+"','"+time.toString()+"','"+type+"','"+name+"','"+phonenumber+"')";
            st.executeUpdate(sql);
            state="success";
            rs.close();
            st.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
        response.getWriter().print(state);
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
