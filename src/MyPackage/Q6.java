package MyPackage;

import java.sql.*;

public class Q6 {
    static String url = "jdbc:mysql://localhost:3306/hospitals";
    static String username = "root";
    static String password = "Lj@0776!";

    public static void q6() {
        try {
            Connection conn = DriverManager.getConnection(url, username, password);
            Statement st = conn.createStatement();
            String query = "SELECT \n" + //
                    "    dc.name AS name,\n" + //
                    "    AVG(DATEDIFF(DATE(a.discharge_date), DATE(a.admission_date))) AS average_stay_duration\n" + //
                    "FROM diagnosis AS d\n" + //
                    "JOIN admission a  \n" + //
                    "    ON a.appointment_id = d.appointment_id\n" + //
                    "JOIN diagnosis_catalog dc \n" + //
                    "    ON dc.diagnosis_code = d.diagnosis_code\n" + //
                    "GROUP BY dc.name\n" + //
                    "ORDER BY dc.name;";

            ResultSet rs = st.executeQuery(query);
                System.out.println("Diagnosis Name"+"|"+ "Avg Stay Duration (days)");

            while (rs.next()) {
                String name = rs.getString("name");
                double avgDuration = rs.getDouble("average_stay_duration");
                System.out.println(name+"|"+ avgDuration);
            }
            rs.close();
            st.close();
            conn.close();
        } catch (Exception e) {
                e.printStackTrace();
        }

    }
}
