package pack.mybatis;

import java.io.InputStream;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.io.Resources;

public class SqlMapConfig {
    private static SqlSessionFactory factory;

    static {
        try {
            String resource = "pack/mybatis/Configuration.xml";
            InputStream inputStream = Resources.getResourceAsStream(resource);
            factory = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (Exception e) {
            System.out.println("SqlSessionFactory 생성 실패: " + e.getMessage());
        }
    }
 
    public static SqlSessionFactory getSqlSessionFactory() {
        return factory;
    }
}
