package com.example.dap.infrastructure.datasorce.config

import com.example.dap.infrastructure.datasorce.JdbcWrapper
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties
import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
@EnableTransactionManagemen
class MysqlConfiguration {
    @Bean
    @ConfigurationProperties(prefix = "spring.datasource.mysql")
    fun dataSourceProperties(): DataSourceProperties {
        return DataSourceProperties()
    }

    @Bean
    fun datasource(dataSourceProperties: DataSourceProperties): DriverManagerDataSource {
        val driverManagerDataSource = DriverManagerDataSource()
        driverManagerDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver")
        driverManagerDataSource.url = dataSourceProperties.url!!
        driverManagerDataSource.username = dataSourceProperties.username!!
        driverManagerDataSource.password = dataSourceProperties.password!!
        return driverManagerDataSource
    }

    @Bean
    fun transactionManager(dataSource: DriverManagerDataSource): JdbcTemplate {
        return JdbcTemplate(dataSource)
    }

    @Bean("mysql")
    fun jdbcWrapper(): JdbcWrapper = JdbcWrapper(jdbcTemplate(datasource(dataSourceProperties())))
}