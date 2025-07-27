    package MyPackage;

    import java.sql.*;

    public class Q2 {
                    static String url = "jdbc:mysql://localhost:3306/hospitals";
                    static String username = "root";
                    static String password = "Lj@0776!";

                    public static void q2() {
                        try {

                            Connection conn = DriverManager.getConnection(url, username, password);
                            Statement st = conn.createStatement();
                            String query = "\n" + //
                        "select b.patient_id , p.first_name, p.last_name, b.total_amount-b.paid_amount as remaining_amount, b.due_date \n"
                        + //
                        "from billing as b \n" + //
                        "join patient p \n" + //
                        "on b.patient_id=p.patient_id\n" + //
                        "where datediff(current_date,due_date)>60 and payment_status=\"pending\";";

                ResultSet rs = st.executeQuery(query);
                    System.out.println("patient_id | first_name | last_name | remaining_amount | due_date");

                while (rs.next()) {
                
                    int patientId = rs.getInt("patient_id");
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    double remainingAmount = rs.getDouble("remaining_amount");
                    Date dueDate = rs.getDate("due_date");
                    System.out.println( patientId +"|"+ firstName + "|" + lastName + "|" + remainingAmount +"|" + dueDate);
                }
                rs.close();
                st.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();

            }
        }
    }
