

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
public class changeroom extends HttpServlet {



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
        
        try 
        {
            Connection conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            
            String getNumber = "select transactionnumber from roomtransaction";
            ResultSet rs2 = st.executeQuery(getNumber);
            rs2.last();
            int transaction_id=Integer.valueOf(rs2.getString(1))+1;
            String id = String.valueOf(transaction_id);
            int longth=id.length();
            StringBuilder transactionid=new StringBuilder();
            for(int i=0;i<(7-longth);i++)
                transactionid.append("0");
            transactionid.append(id);
            String originalRoomNumber = (String) session.getAttribute("originalRoom");
            String roomnumber = (String) session.getAttribute("changenumber");
            String name = (String) session.getAttribute("changeRoomName");
            String indentificationtype = (String) session.getAttribute("changeRoomIndentificationtype");
            String indentificationcode = (String) session.getAttribute("changeRoomIndentificationcode");
            String phonenumber = (String) session.getAttribute("changeRoomPhonenumber");
            String memberid = (String) session.getAttribute("changeRoomMemberid");
            String staffid = (String) session.getAttribute("username");
            String orderid = (String) session.getAttribute("changeRoomOrderid");
            
            String addTransaction = "insert into roomtransaction values('"+transactionid.toString()+"','changeroom','"+ roomnumber+"','"+name+"','"+indentificationtype+"','"+indentificationcode+"','"+ phonenumber+"','"+memberid+"','"+staffid+"',"+orderid +")";
            st.executeUpdate(addTransaction);
            
            String setRoomState = "update roomstate set state='using' , transactionnumber='"+transactionid.toString()+"' where roomnumber='"+roomnumber+"'";
            st.executeUpdate(setRoomState);
            
            String setRoomState2 = "update roomstate set state='available' , transactionnumber='"+transactionid.toString()+"' where roomnumber='"+originalRoomNumber+"'";
            st.executeUpdate(setRoomState2);
            
            String setOrderState = "update preorderinfo_room set state='changeroom' where orderid="+orderid;
            st.executeUpdate(setOrderState);
            
            st.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            response.getWriter().print("fail");
            return;
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
