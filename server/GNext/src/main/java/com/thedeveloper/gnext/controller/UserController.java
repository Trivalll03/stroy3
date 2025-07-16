package com.thedeveloper.gnext.controller;

import com.thedeveloper.gnext.entity.UserEntity;
import com.thedeveloper.gnext.enums.UserRole;
import com.thedeveloper.gnext.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {

    private final UserRepository userRepository;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody UserEntity user) {
        if (userRepository.existsByPhone(user.getPhone())) {
            return ResponseEntity.badRequest().body("Phone already registered");
        }
        if (user.getRole() == null) {
            user.setRole(UserRole.USER);
        }
        return ResponseEntity.ok(userRepository.save(user));
    }
}
