        package MyPackage;

        import java.sql.*;
            

        public class Q3 {
            static String url = "jdbc:mysql://localhost:3306/hospitals";
            static String username = "root";
            static String password = "Lj@0776!";

            public static void q3() {
                try {
                    Connection conn = DriverManager.getConnection(url, username, password);
                    Statement st = conn.createStatement();
                        String query= "SELECT \n" + //
                                                "    DATE_FORMAT(performed_at, \"%Y-%m\") AS procedure_month,\n" + //
                                                "    COUNT(*) AS no_of_procedures\n" + //
                                                "FROM `procedure`\n" + //
                                                "GROUP BY procedure_month\n" + //
                                                "ORDER BY procedure_month;";
                                            ResultSet rs=st.executeQuery(query);
                                                    System.out.println("procedure_month | no_of_procedures");

                                        while(rs.next()){
                                                String month = rs.getString("procedure_month");
                        int count = rs.getInt("no_of_procedures");
                        System.out.println(month + " | " + count);
                                        }
                                        rs.close();
                                        st.close();
                                        conn.close();
                    } catch (Exception e) {

                }

            }
        }
