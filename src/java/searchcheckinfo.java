/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
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
public class searchcheckinfo extends HttpServlet {




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
        String roomnumber = request.getParameter("roomnumber");
        System.out.println(roomnumber);
        
        HttpSession session = request.getSession();  
        session.removeAttribute("checkoutRoomNumber");
        String result = "";
        try 
        {
            Connection conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            String getRecord = "select * from roomstate where roomnumber='"+roomnumber+"'";
            session.setAttribute("checkoutRoomNumber", roomnumber);
            Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rs = st.executeQuery(getRecord);
            String state = "";
            if(rs.next())
                state = rs.getString(2);
            else
            {
                session.removeAttribute("checkoutRoomNumber");
                result = "no such room";
                response.getWriter().print(result);
                return;
            }
            if(state.equals("using"))
            {
                String transnumber = rs.getString(3);
                String type = rs.getString(6);
                String getinfo = "select p.orderid,p.startdate,r.memberid,r.phonenumber,r.IDENTIFICATIONTYPE,r.IDENTIFICATIONNUMBER,r.name,rs.price from roomtransaction r,preorderinfo_room p,roomstate rs where rs.roomnumber=r.roomnumber and p.orderid=r.orderid and r.transactionnumber='"+transnumber+"'";
                ResultSet rs2 = st.executeQuery(getinfo);
                rs2.next();
                String orderid = String.valueOf(rs2.getInt(1));
                String memberid = rs2.getString(3);
                String phonenumber = rs2.getString(4);
                String indentificationtype = rs2.getString(5);
                String indentificationcode = rs2.getString(6);
                String name = rs2.getString(7);
                int price =rs2.getInt(8);
                session.setAttribute("checkoutName", name);
                session.setAttribute("checkoutIndentificationcode", indentificationcode);
                session.setAttribute("checkoutIndentificationtype", indentificationtype);
                session.setAttribute("checkoutPhonenumber", phonenumber);
                session.setAttribute("checkoutMemberid", memberid);
                session.setAttribute("checkoutOrderid", orderid);
                
                Date startDate = rs2.getDate(2);
                Calendar cl = Calendar.getInstance();
                Date endDate = new Date(cl.get(Calendar.YEAR)-1900,cl.get(Calendar.MONTH),cl.get(Calendar.DATE));            
                int duration =(int) Math.round(((endDate.getTime()-startDate.getTime())/86400000.0)) + 1;
                String d = String.valueOf(duration);
                int amount = duration * price;
                result = String.valueOf(price) + " * " + d + " = " + String.valueOf(amount);
            }
            else
            {
                result = "This room have not check in yew.";
            }
            
            
            st.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            result = "SQL exception";
        }
        
        response.getWriter().print(result);
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
