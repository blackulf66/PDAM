package com.salesianos.triana.finalProyect.security;


import com.salesianos.triana.finalProyect.security.jwt.JwtAccessDeniedHandler;
import com.salesianos.triana.finalProyect.security.jwt.JwtAuthorizationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;


@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Configuration
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationEntryPoint authenticationEntryPoint;
    private final JwtAuthorizationFilter filter;
    private final JwtAccessDeniedHandler accessDeniedHandler;


    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().configurationSource(corsConfigurationSource());
        http.csrf().disable()
                .exceptionHandling()
                .authenticationEntryPoint(authenticationEntryPoint)
                .accessDeniedHandler(accessDeniedHandler)
                .and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()
                //auth
                .antMatchers(HttpMethod.POST, "/auth/register").permitAll()
                .antMatchers(HttpMethod.POST, "/auth/login").anonymous()
                .antMatchers(HttpMethod.GET, "/me").authenticated()
                //file
                .antMatchers(HttpMethod.GET, "/download/{filename:.+}").permitAll()
                //subpost
                .antMatchers(HttpMethod.POST, "/subpost/").authenticated()
                .antMatchers(HttpMethod.DELETE , "/subpost/{id}").authenticated()
                .antMatchers(HttpMethod.PUT , "/subpost/{id}").authenticated()
                .antMatchers(HttpMethod.GET, "/subpost/{id}").authenticated()
                .antMatchers(HttpMethod.GET, "/subpost/{name}").authenticated()
                .antMatchers(HttpMethod.GET, "/subpost/all").authenticated()


                //post
                .antMatchers(HttpMethod.POST, "/post/").authenticated()
                .antMatchers(HttpMethod.DELETE, "/post/").authenticated()
                .antMatchers(HttpMethod.PUT, "/post/").authenticated()
                .antMatchers(HttpMethod.GET, "/post/").authenticated()
                .antMatchers(HttpMethod.GET, "/post/{name}").authenticated()
                .antMatchers(HttpMethod.GET, "/post/all").authenticated()
                .antMatchers(HttpMethod.GET, "/post/subpost/{id}").authenticated()

                //vote&Follow
                .antMatchers(HttpMethod.GET, "/follow/{id}").authenticated()
                .antMatchers(HttpMethod.GET, "/unfollow/{id}").authenticated()
                .antMatchers(HttpMethod.POST, "/votes/").authenticated()








                //user
                .antMatchers(HttpMethod.GET, "/user/{id}").authenticated()
                .antMatchers(HttpMethod.PUT, "/user/{id}").authenticated()
                .antMatchers("/h2-console/**").anonymous()



                .anyRequest().permitAll();
        http.csrf().disable();
        http.headers().frameOptions().disable();

        http.addFilterBefore(filter, UsernamePasswordAuthenticationFilter.class);

    }
    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("*"));
        configuration.setAllowedMethods(Arrays.asList("GET","POST","DELETE","PUT"));
        configuration.setAllowedHeaders(Collections.singletonList("*"));
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
