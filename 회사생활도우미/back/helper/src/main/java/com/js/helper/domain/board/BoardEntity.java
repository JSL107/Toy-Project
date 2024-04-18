package com.js.helper.domain.board;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tbl_board")
public class BoardEntity {
    @Id
    @GeneratedValue
    private int id;
    private String title;
    private String content;
    private String author;
    private String image;
    private String type;
    private String status;
    private String created;
    private String updated;
}
