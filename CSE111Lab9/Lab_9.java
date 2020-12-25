// STEP: Import required packages
import java.sql.*;
import java.io.FileWriter;
import java.io.PrintWriter;

public class Lab_9 {
    private Connection c = null;
    private String dbName;
    private boolean isConnected = false;

    private void openConnection(String _dbName) {
        dbName = _dbName;

        if (false == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Open database: " + _dbName);

            try {
                String connStr = new String("jdbc:sqlite:");
                connStr = connStr + _dbName;

                // STEP: Register JDBC driver
                Class.forName("org.sqlite.JDBC");

                // STEP: Open a connection
                c = DriverManager.getConnection(connStr);

                // STEP: Diable auto transactions
                c.setAutoCommit(false);

                isConnected = true;
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void closeConnection() {
        if (true == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Close database: " + dbName);

            try {
                // STEP: Close connection
                c.close();

                isConnected = false;
                dbName = "";
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void create_View1() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V1");

        try {
            Statement stmt = c.createStatement();

            String sql = "CREATE VIEW V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) AS " +
            "SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nationkey, n_regionkey " +
            "FROM customer, nation " +
            "WHERE " + "c_nationkey = n_nationkey;";
            stmt.execute(sql);

            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q1() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q1");

        try {
            FileWriter writer = new FileWriter("output/1.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select c_name as cName, sum(o_totalprice) as totPr " +
                "FROM V1, orders, nation " +
                "WHERE o_custkey = c_custkey AND " +
                "n_nationkey = c_nation AND " +
                "n_name = 'RUSSIA' AND " +
                "o_orderdate LIKE '1996-__-__' " +
                "GROUP BY c_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next()){
                String name = rs.getString("cName");
                String totPrice = rs.getString("totPr");
                printer.printf("%-40s|%-40s\n", name, totPrice);
            }

            rs.close();
            stmt.close(); 
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View2() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V2");

        try {
            Statement stmt = c.createStatement();

            String sql = "CREATE VIEW V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) AS " +
            "SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nationkey, n_regionkey " +
            "FROM supplier, nation " +
            "WHERE " +
                "s_nationkey = n_nationkey;";
            stmt.execute(sql);

            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q2() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q2");

        try {
            FileWriter writer = new FileWriter("output/2.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT n_name as nName, count(*) as count " +
            "FROM V2, nation " +
            "WHERE s_nation = n_nationkey " +
            "GROUP BY n_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                String name = rs.getString("nName");
                int count = rs.getInt("count");
                printer.printf("%-40s|%10d\n", name, count);
            }
               
            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q3() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q3");

        try {
            FileWriter writer = new FileWriter("output/3.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT n_name as nName, count(*) as count " +
                "FROM orders, nation, V1, region " +
                "WHERE c_custkey = o_custkey AND " +
                "c_nation = n_nationkey AND " +
                "n_regionkey = r_regionkey AND " +
                "r_name = 'ASIA' " +
                "GROUP BY n_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                String name = rs.getString("nName");
                int count = rs.getInt("count");
                printer.printf("%-40s|%10d\n", name, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q4() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q4");

        try {
            FileWriter writer = new FileWriter("output/4.out", false);
            PrintWriter printer = new PrintWriter(writer);
            
            String sql = "SELECT s_name as sName, count(*) as count " +
                "FROM partsupp, V2, nation, part " +
                "WHERE p_partkey = ps_partkey " +
                "AND p_size < 30 " +
                "AND ps_suppkey = s_suppkey " +
                "AND s_nation = n_nationkey " +
                "AND n_name = 'CHINA' " +
                "GROUP BY s_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                String name = rs.getString("sName");
                int count = rs.getInt("count");
                printer.printf("%-40s|%10d\n", name, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View5() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V5");
        try {
            Statement stmt = c.createStatement();

            String sql = "CREATE VIEW V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) AS " +
            "SELECT * FROM orders";
            stmt.execute(sql);

            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q5() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q5");

        try {
            FileWriter writer = new FileWriter("output/5.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT count(*) as count " +
                "FROM V5, V1, nation " +
                "WHERE o_custkey = c_custkey " +
                "AND c_nation = n_nationkey " +
                "AND n_name = 'PERU' " +
                "AND o_orderyear like '1996-__-__';";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                int count = rs.getInt("count");
                printer.printf("%-10d\n", count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q6() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q6");

        try {
            FileWriter writer = new FileWriter("output/6.out", false);
            PrintWriter printer = new PrintWriter(writer);
            String sql = "SELECT s_name as sName, o_orderpriority as oPrior, count(*) as count " +
                "FROM partsupp, V5, lineitem, supplier, region, nation  " +
                "WHERE ps_partkey = l_partkey " +
                "AND ps_suppkey = l_suppkey " +
                "AND l_orderkey = o_orderkey " +
                "AND ps_suppkey = s_suppkey " +
                "AND s_nationkey = n_nationkey " +
                "AND n_regionkey = r_regionkey " +
                "AND r_name = 'AMERICA' " +
                "GROUP BY s_name, o_orderpriority;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                String name = rs.getString("sName");
                String priority = rs.getString("oPrior");
                int count = rs.getInt("count");
                printer.printf("%-40s|%-40s|%10d\n", name, priority, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q7() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q7");

        try {
            FileWriter writer = new FileWriter("output/7.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT n_name as nName, o_orderstatus as oStat, count(*) as count " +
                "FROM V5, V1, nation, region " +
                "WHERE o_custkey = c_custkey " +
                "AND c_nation = n_nationkey " +
                "AND n_regionkey = r_regionkey " +
                "AND r_name = 'EUROPE' " +
                "GROUP BY n_name, o_orderstatus;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                String name = rs.getString("nName");
                String status = rs.getString("oStat");
                int count = rs.getInt("count");
                printer.printf("%-40s|%40s|%10d\n", name, status, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q8() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q8");

        try {
            FileWriter writer = new FileWriter("output/8.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT n_name as nName, count(distinct o_orderkey) as tot_orders " +
                "FROM V5, nation, V2, lineitem " +
                "WHERE o_orderyear like '1994%' " +
                "AND o_orderstatus = 'F' " +
                "AND o_orderkey = l_orderkey " +
                "AND l_suppkey = s_suppkey " +
                "AND s_nation = n_nationkey " +
                "GROUP BY n_name " +
                "HAVING tot_orders > 300;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                String name = rs.getString("nName");
                int tot = rs.getInt("tot_orders");
                printer.printf("%-40s|%10d\n", name, tot);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q9() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q9");

        try {
            FileWriter writer = new FileWriter("output/9.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT count(DISTINCT o_clerk) as count " +
                "FROM V5, V2, nation, lineitem " +
                "WHERE o_orderkey = l_orderkey " +
                "AND l_suppkey = s_suppkey " +
                "AND s_nation = n_nationkey " +
                "AND n_name = 'CANADA';";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next()){
                int count = rs.getInt("count");
                printer.printf("%-10d\n", count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View10() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V10");

        try {
            Statement stmt = c.createStatement();

            String sql = "CREATE VIEW V10(p_type, avg_discount) AS " +
                "SELECT p_type, AVG(l_discount) " +
                "FROM part, lineitem " +
                "WHERE " +
                    "p_partkey = l_partkey " +
                "GROUP BY p_type;";
            stmt.execute(sql);

            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q10() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q10");

        try {
            FileWriter writer = new FileWriter("output/10.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT p_type as type, avg_discount as avgDis " +
                "FROM V10 " +
                "WHERE p_type like '%PROMO%' " +
                "GROUP BY p_type;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                String type = rs.getString("type");
                String discount = rs.getString("avgDis");
                printer.printf("%-40s|%40s\n", type, discount);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q11() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q11");

        try {
            FileWriter writer = new FileWriter("output/11.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT n_name as nName, s_name as sName, s_acctbal as acct " +
                "FROM V2 s, nation n " +
                "WHERE s_nation = n_nationkey " +
                "AND s_acctbal = " +
                    "(SELECT max(s_acctbal) " +
                    "FROM V2 s1 " +
                    "WHERE s.s_nation = s1.s_nation " +
                    ")GROUP BY n_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                String nation = rs.getString("nName");
                String supplier = rs.getString("sName");
                String account = rs.getString("acct");
                printer.printf("%-40s|%-40s|%-40s\n", nation, supplier, account);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q12() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q12");

        try {
            FileWriter writer = new FileWriter("output/12.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT n_name as nName, avg(s_acctbal) as avgBal " +
                "FROM V2, nation " +
                "WHERE s_nation = n_nationkey " +
                "GROUP BY n_name";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                String name = rs.getString("nName");
                String balance = rs.getString("avgBal");
                printer.printf("%-40s|%40s\n", name, balance);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q13() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q13");

        try {
            FileWriter writer = new FileWriter("output/13.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT count(*) as count " +
            "FROM orders, lineitem, V1 " +
            "WHERE o_orderkey = l_orderkey " +
                "AND o_custkey = c_custkey " +
                "AND l_suppkey in ( " +
                    "SELECT s_suppkey " +
                    "FROM V2, nation, region " +
                    "WHERE s_nation = n_nationkey " +
                        "AND n_regionkey = r_regionkey " +
                        "AND r_name = 'ASIA' " +
                    ") " +
                "AND c_custkey in ( " +
                    "SELECT c_custkey " +
                    "FROM V1, nation " +
                    "WHERE c_nation = n_nationkey " +
                        "AND n_name = 'ARGENTINA' " + 
                        ");";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                int count = rs.getInt("count");
                printer.printf("%-10d\n", count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q14() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q14");

        try {
            FileWriter writer = new FileWriter("output/14.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT custRegion as cRegion, suppRegion as sRegion, count(*) as no " +
            "FROM " +
                "orders " +
                "join " +
                "(SELECT o_orderkey as custOrder, r_name as custRegion " +
                "FROM orders, nation, region, V1 " +
                "WHERE o_custkey = c_custkey " +
                    "AND c_nation = n_nationkey " +
                    "AND n_regionkey = r_regionkey " +
                ") ON o_orderkey = custOrder " +
                "JOIN " +
                "(SELECT l_orderkey as suppOrder, r_name as suppRegion " +
                "FROM lineitem, region, nation, V2 " +
                "WHERE l_suppkey = s_suppkey " +
                    "AND s_nation = n_nationkey " +
                    "AND n_regionkey = r_regionkey " +
                ") ON o_orderkey = suppOrder " +
            "GROUP BY custRegion, suppRegion;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                String cust = rs.getString("cRegion");
                String supp = rs.getString("sRegion");
                int count = rs.getInt("no");
                printer.printf("%-40s|%40s|%10d\n", cust, supp, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View151() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V151");

        try {
            Statement stmt = c.createStatement();

            String sql = "CREATE VIEW V151(c_custkey, c_name, c_nationkey, c_acctbal) AS " +
            "SELECT c_custkey, c_name, c_nationkey, c_acctbal " +
            "FROM customer;";
            stmt.execute(sql);

            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View152() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V152");

        try {
            Statement stmt = c.createStatement();

            String sql = "CREATE VIEW V152(s_suppkey, s_name, s_nationkey, s_acctbal) AS " +
            "SELECT s_suppkey, s_name, s_nationkey, s_acctbal " +
            "FROM supplier;";
            stmt.execute(sql);

            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q15() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q15");

        try {
            FileWriter writer = new FileWriter("output/15.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT count(DISTINCT o_orderkey) as count " +
            "FROM orders, lineitem " +
            "WHERE o_orderkey = l_orderkey " +
                "AND o_custkey in " +
                    "(SELECT c_custkey " +
                    "FROM customer " +
                    "WHERE c_acctbal < 0) " +
                "AND l_suppkey in " +
                    "(SELECT s_suppkey " +
                    "FROM V152 " +
                    "WHERE s_acctbal < 0);";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            while(rs.next()){
                int count = rs.getInt("count");
                printer.printf("%-10d\n", count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    public static void main(String args[]) {
        Lab_9 sj = new Lab_9();
        
        sj.openConnection("data/tpch.sqlite");

        sj.create_View1();
        sj.Q1();

        sj.create_View2();
        sj.Q2();

        sj.Q3();
        sj.Q4();

        sj.create_View5();
        sj.Q5();

        sj.Q6();
        sj.Q7();
        sj.Q8();
        sj.Q9();

        sj.create_View10();
        sj.Q10();

        sj.Q11();
        sj.Q12();
        sj.Q13();
        sj.Q14();

        sj.create_View151();
        sj.create_View152();
        sj.Q15();

        sj.closeConnection();
    }
}