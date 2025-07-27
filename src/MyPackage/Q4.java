        package MyPackage;

        import java.sql.*;

        public class Q4 {
            static String url = "jdbc:mysql://localhost:3306/hospitals";
            static String username = "root";
            static String password = "Lj@0776!";

            public static void q4() {
                try {
                    Connection conn = DriverManager.getConnection(url, username, password);
                    Statement st = conn.createStatement();
                    String query = "select * from insurance_claim\n" + //
                            "where status=\"pending\"\n" + //
                            "order by claim_id asc;";

                    ResultSet rs = st.executeQuery(query);
                    System.out.println("claim_id | bill_id | insurance_provider | status | submitted_date | approved_date | claim_amount");
                    while (rs.next()) {
                                                                    
                        int claim_id = rs.getInt("claim_id");
                        int bill_id = rs.getInt("bill_id");
                        String insurance_provider = rs.getString("insurance_provider");
                        String status = rs.getString("status");
                        String submitted_date = rs.getString("submitted_date");
                            String approved_date = rs.getString("approved_date");
                        int claim_amount = rs.getInt("claim_amount");

                        System.out.println(claim_id + " | " + bill_id + " | " + insurance_provider + " | " +
                                status + " | " + submitted_date + " | " + approved_date + " | " + claim_amount);

                    }
                    rs.close();
                    st.close();
                    conn.close();
                } catch (Exception e) {

                }

            }
        }
