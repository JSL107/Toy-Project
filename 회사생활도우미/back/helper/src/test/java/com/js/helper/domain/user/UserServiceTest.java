package com.js.helper.domain.user;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;

@SpringBootTest
class UserServiceTest {

    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
    @InjectMocks
    private UserServiceImpl userService;

    @Mock
    private UserRepository userRepository;


    @Test
    void registerUser_ValidUser_Success() {
        // Given
        UserEntity userEntity = new UserEntity();
        userEntity.setId("test");
        userEntity.setName("테스트");
        userEntity.setEmail("test@test.com");
        userEntity.setPassword("123456");
        userEntity.setBirthday(new Date());
        userEntity.setAuth(Auth.user);

        // When
        userService.registerUser(userEntity);
        userRepository.save(userEntity);

        // Then
        logger.info("회원가입 성공 {}", userEntity.getId());
    }
}
