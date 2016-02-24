/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Kehao Xu
 */
public class signin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phonenumber = request.getParameter("phonenumber");
        String connectionURL = "jdbc:derby://localhost:1527/kex3";
        HttpSession session = request.getSession(); 
        String re = "";
        try 
        {
            Connection conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            String getRecord = "select * from account where username='"+username+"'";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(getRecord);
            if(rs.next())
            {
                re = "";
            }
            else
            {
                re = "index.jsp";
                String addAccount = "insert into account values('"+username+"','"+password+"','customer','"+name+"','"+phonenumber+"')";
                st.executeUpdate(addAccount);
                session.setAttribute("username", username);
                session.setAttribute("type", "customer");
            }
            rs.close();
            st.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
        response.getWriter().print(re);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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
        processRequest(request, response);
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
