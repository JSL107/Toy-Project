package com.js.helper.domain.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
public class UserController {

    final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("api/register")
    public void register(@RequestBody UserEntity userEntity) {
        userService.registerUser(userEntity);
    }
}
