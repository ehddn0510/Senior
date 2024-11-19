package edu.sm.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SpringSecurity {

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public StandardPBEStringEncryptor textEncoder(@Value("${app.key.algo}") String algo, @Value("${app.key.skey}") String skey) {
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setAlgorithm(algo);
        encryptor.setPassword(skey);
        return encryptor;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // csrf 설정을 비활성화
        http.csrf((csrf) -> csrf.disable());

        // 권한 규칙 작성
        http.authorizeHttpRequests(authorize -> authorize
                .anyRequest().permitAll() // 모든 요청 허용
        );

        http.logout(logout -> logout
                .logoutUrl("/logout") // 로그아웃 요청 경로
                .logoutSuccessUrl("/") // 로그아웃 성공 후 이동할 경로
                .invalidateHttpSession(true) // 세션 무효화
                .deleteCookies("JSESSIONID") // 쿠키 삭제
                .permitAll() // 누구나 접근 가능
        );

        return http.build();
    }
}
