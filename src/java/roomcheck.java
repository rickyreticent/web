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
public class roomcheck extends HttpServlet {


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
        String ed = request.getParameter("enddate");
        Date startDate = new Date(Integer.valueOf(sd.split("/")[2])-1900,Integer.valueOf(sd.split("/")[0])-1,Integer.valueOf(sd.split("/")[1]));
        Date endDate = new Date(Integer.valueOf(ed.split("/")[2])-1900,Integer.valueOf(ed.split("/")[0])-1,Integer.valueOf(ed.split("/")[1]));
        int price = -1;
        HttpSession session = request.getSession(); 
        session.removeAttribute("roomnumber");
        session.removeAttribute("startdate");
        session.removeAttribute("enddate");
//        System.out.println(startDate.toString());
//        System.out.println(endDate.toString());
        String connectionURL = "jdbc:derby://localhost:1527/kex3";
        try 
        {
            Connection conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            String check = "SELECT pr.startdate,pr.enddate,pr.roomnumber,rs.price,pr.state FROM preorderinfo_room pr,roomstate rs where pr.roomnumber=rs.roomnumber and rs.capacity="+number+" and rs.type='"+type+"'";
            Statement st = conn.createStatement();
            ResultSet rs=null;
            rs=st.executeQuery(check);
            List<String> notaval = new ArrayList<String>();
            if(!rs.next())
            {
                String getroom = "select price,roomnumber from roomstate where capacity="+number+" and type='"+type+"'";
                rs = st.executeQuery(getroom);
                if(rs.next())
                {
                    price = rs.getInt(1);
                    session.setAttribute("roomnumber", rs.getString(2));
                    session.setAttribute("startdate", startDate);
                    session.setAttribute("enddate", endDate);
                }
            }
            else
            {
                do
                {   
                    if(rs.getDate(1).equals(endDate)||rs.getDate(1).equals(startDate))
                    {
                        notaval.add(rs.getString(3));
                        if(rs.getString(5).equals("canceled")|| rs.getString(5).equals("checkout"))
                        {
                            notaval.remove(notaval.size()-1);
                        }
                        continue;
                    }
                    if(rs.getDate(2).equals(endDate)||rs.getDate(2).equals(startDate))
                    {
                        notaval.add(rs.getString(3));
                        if(rs.getString(5).equals("canceled")|| rs.getString(5).equals("checkout"))
                        {
                            notaval.remove(notaval.size()-1);
                        }
                        continue;
                    }
                    if((rs.getDate(1).before(endDate) && rs.getDate(1).after(startDate)) || (rs.getDate(2).after(startDate) && rs.getDate(2).before(endDate)))
                    {
                        notaval.add(rs.getString(3));
                        if(rs.getString(5).equals("canceled") || rs.getString(5).equals("checkout"))
                        {
                            notaval.remove(notaval.size()-1);
                        }
                        continue;
                    }
                    
                }while(rs.next());
                
                String getroom = "select price,roomnumber from roomstate where capacity="+number+" and type='"+type+"'";
                rs = st.executeQuery(getroom);
                while(rs.next())
                {
                    if(!notaval.contains(rs.getString(2)))
                    {
                        price = rs.getInt(1);
                        session.setAttribute("roomnumber", rs.getString(2));
                        session.setAttribute("startdate", startDate);
                        session.setAttribute("enddate", endDate);
                        break;
                    }
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
