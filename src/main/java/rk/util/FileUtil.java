package rk.util;

import java.io.*;

public class FileUtil {

    public static void copyFile(String inputFilePath,String outputFilePath) throws IOException {

        InputStream is = new FileInputStream(new File(inputFilePath));
        OutputStream os = new FileOutputStream(outputFilePath);
        byte[] buffer = new byte[1024];
        while (is.read(buffer)>0){
            os.write(buffer);
        }
        os.flush();
        is.close();
        os.close();
    }
}
