    package MyPackage;

    import java.sql.*;

    public class Q1 {
        static String url = "jdbc:mysql://localhost:3306/hospitals";
        static String username = "root";
        static String password = "Lj@0776!";

        public static void q1() {
            try {
        

                    Connection conn = DriverManager.getConnection(url, username, password);
                    Statement st= conn.createStatement();
                    String q1 = "with upcoming_appointments as (\n" +
                "    select *, dense_rank() over(\n" +
                "        partition by department_id\n" +
                "        order by date\n" +
                "    ) as dep\n" +
                "    from appointment\n" +
                ")\n" +
                "select appointment_id, patient_id, staff_id, date, start_time, end_time, room_id, status \n" +
                "from upcoming_appointments\n" +
                "where date >= current_date();";

        ResultSet rs = st.executeQuery(q1);
         System.out.println("appointment_id | patient_id | staff_id | date | start_time - end_time | Room | Status");

    while (rs.next()) {
        int appointmentId = rs.getInt("appointment_id");
        int patientId = rs.getInt("patient_id");
        int staffId = rs.getInt("staff_id");
        Date date = rs.getDate("date");
        Time startTime = rs.getTime("start_time");
        Time endTime = rs.getTime("end_time");
        int roomId = rs.getInt("room_id");
        String status = rs.getString("status");
            
        System.out.println(appointmentId + " | " + patientId + " | " + staffId + " | " + date + " | " + startTime + " - " + endTime + " | Room: " + roomId + " | Status: " + status);
    }

        rs.close();
        st.close();
        conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        
        }
    }
