package edu.sm.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Paths;

@Slf4j
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Value("${app.dir.imgdir}")
    String imgDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String seniorDir = Paths.get(imgDir, "senior").toString();
        String careworkerDir = Paths.get(imgDir, "careworker").toString();
        String userDir = Paths.get(imgDir, "user").toString();
        seniorDir = seniorDir + "/";
        careworkerDir = careworkerDir + "/";
        userDir = userDir + "/";

        registry.addResourceHandler("/imgs/senior/**").addResourceLocations(seniorDir);
        registry.addResourceHandler("/imgs/careworker/**").addResourceLocations(careworkerDir);
        registry.addResourceHandler("/imgs/user/**").addResourceLocations(userDir);
    }

}