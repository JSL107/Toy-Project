package com.js.helper.domain.user;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.sql.Timestamp;
import java.util.Date;

@Entity
@Table(name = "tbl_user")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserEntity {
    @Id
    @Column(nullable = false, unique = true)
    private String id;

    @Column(nullable = false)
    private String name;

    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private Date birthday;

    @Column(nullable = false)
    private Auth auth = Auth.user;

    @CreationTimestamp
    private Timestamp createAt;

//    private String phoneNumber;
//    private String address;
//    private String city;
//    private String state;
//    private String country;
//    private String zip;
//    private String gender;
}
