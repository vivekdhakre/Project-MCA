import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by vivek on 13/5/17.
 */
public class Test {

    public static void main(String[] args) {
        String fDate = "05/13/2017";
        String tDate = "05/18/2017";

        try {

            DateFormat format = new SimpleDateFormat("MM/dd/yyyy");
            DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
            DateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            Date fd1 = format.parse(fDate);
            Date td1 = format.parse(tDate);

            Date nextD = null;
            int i = 0;
            do {
                Calendar c = Calendar.getInstance();
                c.setTime(fd1);
                c.add(Calendar.DATE, i++);
                nextD = c.getTime();

                System.out.println(format2.parse(format2.format(format2.parse(format1.format(nextD) + " 00:00:00"))));
                System.out.println(new java.sql.Timestamp(format2.parse(format2.format(format2.parse(format1.format(nextD) + " 23:00:00"))).getTime()));

                System.out.println(nextD);
            } while (!td1.equals(nextD));

        } catch (Exception e) {
        }


    }
}

