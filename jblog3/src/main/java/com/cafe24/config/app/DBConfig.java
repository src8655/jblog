package com.cafe24.config.app;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@PropertySource("classpath:com/cafe24/config/app/properties/jdbc.properties")
public class DBConfig {
	
	@Autowired
	private Environment env;

	@Bean
	public DataSource basicDataSource() {
		BasicDataSource basicDataSeource = new BasicDataSource();
		basicDataSeource.setDriverClassName(env.getProperty("jdbc.driverClassNAme"));
		basicDataSeource.setUrl(env.getProperty("jdbc.url"));
		basicDataSeource.setUsername(env.getProperty("jdbc.username"));
		basicDataSeource.setPassword(env.getProperty("jdbc.password"));
		basicDataSeource.setInitialSize(env.getProperty("jdbc.initialSize", Integer.class));
		basicDataSeource.setMaxActive(env.getProperty("jdbc.maxActive", Integer.class));
		
		return basicDataSeource;
	}
	
	@Bean
	public PlatformTransactionManager transactionManager(DataSource dataSource) {
		return new DataSourceTransactionManager(dataSource);
	}
}
