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
public class diningcheck extends HttpServlet {


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
        
        response.setContentType("text/html;charset=UTF-8");
        String type = request.getParameter("type");
        String number = request.getParameter("number");
        String sd = request.getParameter("startdate");
        String hour = request.getParameter("hour");
        String minute = request.getParameter("minute");
        Date startDate = new Date(Integer.valueOf(sd.split("/")[2])-1900,Integer.valueOf(sd.split("/")[0])-1,Integer.valueOf(sd.split("/")[1]));
        Time startTime = new Time(Integer.valueOf(hour),Integer.valueOf(minute),0);
        Time endTime = new Time(Integer.valueOf(hour)+2,Integer.valueOf(minute),0);
        int price = -1;
        HttpSession session = request.getSession(); 
        
        String connectionURL = "jdbc:derby://localhost:1527/kex3";
        try 
        {
            Connection conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            String check = "SELECT * from preorderinfo_dining where startdate = '"+startDate+"' and type='"+type+"'";
            Statement st = conn.createStatement();
            ResultSet rs=null;
            rs=st.executeQuery(check);
            if(!rs.next())
            {
                price = 1;
                session.setAttribute("type_dining", type);
                session.setAttribute("startdate_dining", startDate);
                session.setAttribute("time_dining", startTime);
                session.setAttribute("number_dining", number);
                
            }
            else
            {
                int totalNum = 0;
                do
                {   
                    Time t = rs.getTime(4);                    
                    if((t.before(endTime) && t.after(startTime)) || (t.after(startTime) && t.before(endTime)))
                    {
                        totalNum = totalNum + rs.getInt(2);
                        continue;
                    }                    
                }while(rs.next());
                if((totalNum+Integer.valueOf(number))<=100)
                {
                    price = 1;
                    session.setAttribute("type_dining",type);
                    session.setAttribute("startdate_dining", startDate);
                    session.setAttribute("time_dining", startTime);
                    session.setAttribute("number_dining", number);
                }
            }
            rs.close();
            st.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
        response.getWriter().print(price);
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
