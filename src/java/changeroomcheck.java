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
public class changeroomcheck extends HttpServlet {

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
        
        String connectionURL = "jdbc:derby://localhost:1527/kex3";        
        String roomnumber = request.getParameter("roomnumber");
        String changeNumber = "";
        HttpSession session = request.getSession();        
        
        try 
        {
            Connection conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            String getRecord = "select * from roomstate where roomnumber='"+roomnumber+"'";
            Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rs = st.executeQuery(getRecord);
            String state = "";
            if(rs.next())
                state = rs.getString(2);
            if(state.equals("using"))
            {
                String transnumber = rs.getString(3);
                String type = rs.getString(6);
                session.setAttribute("changeRoomType", type);
                String number = String.valueOf(rs.getInt(5));
                String getinfo = "select p.orderid,p.enddate,r.memberid,r.phonenumber,r.IDENTIFICATIONTYPE,r.IDENTIFICATIONNUMBER,r.name from roomtransaction r,preorderinfo_room p where p.orderid=r.orderid and transactionnumber='"+transnumber+"'";
                ResultSet rs2 = st.executeQuery(getinfo);
                rs2.next();
                String orderid = String.valueOf(rs2.getInt(1));
                String memberid = rs2.getString(3);
                String phonenumber = rs2.getString(4);
                String indentificationtype = rs2.getString(5);
                String indentificationcode = rs2.getString(6);
                String name = rs2.getString(7);
                session.setAttribute("changeRoomName", name);
                session.setAttribute("changeRoomIndentificationcode", indentificationcode);
                session.setAttribute("changeRoomIndentificationtype", indentificationtype);
                session.setAttribute("changeRoomPhonenumber", phonenumber);
                session.setAttribute("changeRoomMemberid", memberid);
                session.setAttribute("changeRoomOrderid", orderid);
                Date endDate = rs2.getDate(2);
                Calendar cl = Calendar.getInstance();
                Date startDate = new Date(cl.get(Calendar.YEAR)-1900,cl.get(Calendar.MONTH),cl.get(Calendar.DATE));
                if(startDate.equals(endDate))
                {
                    changeNumber = "Cannot change when today is the end day";
                }
                else
                {
                    String check = "SELECT pr.startdate,pr.enddate,pr.roomnumber,rs.price FROM preorderinfo_room pr,roomstate rs where pr.roomnumber=rs.roomnumber and rs.capacity="+number+" and rs.type='"+type+"'";
                    System.out.println(check);
                    ResultSet rs3=st.executeQuery(check);
                    List<String> notaval = new ArrayList<String>();
                    if(!rs3.next())
                    {
                        String getroom = "select price,roomnumber from roomstate where capacity="+number+" and type='"+type+"'";
                        ResultSet rs4 = st.executeQuery(getroom);
                        while(rs4.next())
                        {
                            if(!rs4.getString(2).equals(roomnumber))
                            {
                                changeNumber = rs4.getString(2);
                                session.setAttribute("changenumber", changeNumber);
                                break;
                            }                           
                        }
                    }
                    else
                    {
                        do
                        {   
                            if(rs3.getString(3).equals(roomnumber))
                            {
                                notaval.add(rs3.getString(3));
                                continue;
                            }
                            if(rs3.getDate(1).equals(endDate)||rs3.getDate(1).equals(startDate))
                            {
                                notaval.add(rs3.getString(3));
                                continue;
                            }
                            if(rs3.getDate(2).equals(endDate)||rs3.getDate(2).equals(startDate))
                            {
                                notaval.add(rs3.getString(3));
                                continue;
                            }
                            if((rs3.getDate(1).before(endDate) && rs3.getDate(1).after(startDate)) || (rs3.getDate(2).after(startDate) && rs3.getDate(2).before(endDate)))
                            {
                                notaval.add(rs3.getString(3));
                                continue;
                            }
                            changeNumber = rs3.getString(3);
                            session.setAttribute("changenumber", changeNumber);                
                        }while(rs3.next());
                        
                        String getroom = "select price,roomnumber from roomstate where capacity="+number+" and type='"+type+"'";
                        ResultSet rs4 = st.executeQuery(getroom);
                        while(rs4.next())
                        {
                            if(!notaval.contains(rs4.getString(2)))
                            {
                                changeNumber = rs4.getString(2);
                                session.setAttribute("changenumber", changeNumber);
                                break;
                            }                           
                        }
                    }
                    if(changeNumber.isEmpty())
                        changeNumber = "No room available now!";
                    
                }
                
            }
            else
            {
                changeNumber = "This room have not check in yew.";
            }
            
            
            st.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            changeNumber = "SQL exception";
        }
        session.setAttribute("originalRoom", roomnumber);
        response.getWriter().print(changeNumber);
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
