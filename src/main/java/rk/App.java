package rk;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Hello world!
 *
 */
@SpringBootApplication
@MapperScan(basePackages = "rk.dao")
public class App implements CommandLineRunner
{


    public static void main( String[] args )
    {
        SpringApplication.run(App.class,args);
    }

    @Override
    public void run(String... strings) throws Exception {
        System.out.println("启动成功");
    }
}
