package com.AW.DataBaseWeb.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.concurrent.TimeUnit;

@Configuration
public class WebConfig implements WebMvcConfigurer{

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/webjars/**")
                .addResourceLocations("/webjars/")
                .setCacheControl(CacheControl.maxAge(24, TimeUnit.HOURS));

        registry
                .addResourceHandler("/**")
                .addResourceLocations("classpath:/resources/", "classpath:/static/")
                .setCacheControl(CacheControl.maxAge(24, TimeUnit.HOURS));

    }

}
