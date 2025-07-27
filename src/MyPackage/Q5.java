                package MyPackage;

                import java.sql.*;

                public class Q5{
                    static String url = "jdbc:mysql://localhost:3306/hospitals";
                    static String username = "root";
                    static String password = "Lj@0776!";

                    public static void q5() {
                        try {
                            Connection conn = DriverManager.getConnection(url, username, password);
                            Statement st = conn.createStatement();
                            String query = "\n" + //
                                                            "WITH q5 AS (\n" + //
                                                        "    SELECT \n" + //
                                                        "        s1.staff_id, \n" + //
                                                        "        s.shift_id,\n" + //
                                                        "        TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time) AS shift_duration_minutes,\n" + //
                                                        "        IFNULL(SUM(TIMESTAMPDIFF(MINUTE, p.performed_at, p.end_time)), 0) AS total_procedure_time,\n" + //
                                                        "        IFNULL(SUM(TIMESTAMPDIFF(MINUTE, a.start_time, a.end_time)), 0) AS total_appointment_time,\n" + //
                                                        "        ROUND(\n" + //
                                                        "            (\n" + //
                                                        "                IFNULL(SUM(TIMESTAMPDIFF(MINUTE, p.performed_at, p.end_time)), 0) +\n" + //
                                                        "                IFNULL(SUM(TIMESTAMPDIFF(MINUTE, a.start_time, a.end_time)), 0)\n" + //
                                                        "            ) / TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time) * 100\n" + //
                                                        "        , 2) AS doctor_utilization_rate\n" + //
                                                        "    FROM shift s\n" + //
                                                        "    JOIN staff_schedule s1 ON s.shift_id = s1.shift_id\n" + //
                                                        "    LEFT JOIN `procedure` p \n" + //
                                                        "        ON p.staff_id = s1.staff_id\n" + //
                                                        "        AND p.performed_at BETWEEN s.start_time AND s.end_time\n" + //
                                                        "    LEFT JOIN appointment a \n" + //
                                                        "        ON a.staff_id = s1.staff_id\n" + //
                                                        "        AND a.start_time BETWEEN s.start_time AND s.end_time\n" + //
                                                        "    GROUP BY s.shift_id, s1.staff_id\n" + //
                                                        ")\n" + //
                                                        "SELECT staff_id, shift_id, doctor_utilization_rate FROM q5;";

                            ResultSet rs = st.executeQuery(query);
                            System.out.println("staff_id | shift_id | doctor_utilization_rate");

                while (rs.next()) {
                    int staffId = rs.getInt("staff_id");
                    int shiftId = rs.getInt("shift_id");
                    double utilization = rs.getDouble("doctor_utilization_rate");

                    System.out.println(staffId + " | " + shiftId + " | " + utilization + "%");
                }
                            rs.close();
                            st.close();
                            conn.close();
                        } catch (Exception e) {

                        }

                    }
                }
