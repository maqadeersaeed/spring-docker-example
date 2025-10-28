package com.maqs.simple_spring_app.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
@Slf4j
public class HelloWorldController {

    @GetMapping("/say-hello")
    public ResponseEntity<String> helloWorld() {
        return ResponseEntity.ok("Hello, Life is beautiful!");
    }

}
