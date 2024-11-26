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
        String baseDir = imgDir.replace("file:", "").trim();
        String seniorDir = Paths.get(baseDir, "senior").toString().replace("\\", "/") + "/";
        String careworkerDir = Paths.get(baseDir, "careworker").toString().replace("\\", "/") + "/";
        String userDir = Paths.get(baseDir, "user").toString().replace("\\", "/") + "/";

        registry.addResourceHandler("/imgs/senior/**").addResourceLocations("file:" + seniorDir);
        registry.addResourceHandler("/imgs/careworker/**").addResourceLocations("file:" + careworkerDir);
        registry.addResourceHandler("/imgs/user/**").addResourceLocations("file:" + userDir);
    }
}