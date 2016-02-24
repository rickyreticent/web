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
public class paysubscription extends HttpServlet {




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
        String[] paying = request.getParameter("paying").split("-");
        int[] index = new int[paying.length];
        for(int i=0;i<index.length;i++)
        {
            index[i] = Integer.valueOf(paying[i]);
        }
        HttpSession session = request.getSession();
        List<Integer> subscription = (List<Integer>) session.getAttribute("subscription");
        String connectionURL = "jdbc:derby://localhost:1527/kex3";
        
        try 
        {
            Connection conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            Statement st = conn.createStatement();
            for(int i=0;i<index.length;i++)
            {
                String sql = "update preorderinfo_room set state='prepared' where orderid="+String.valueOf(subscription.get(index[i]));
                st.executeUpdate(sql);
            }
            st.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
        response.getWriter().print("success");
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
