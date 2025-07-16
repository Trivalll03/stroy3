package com.thedeveloper.gnext.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.List;

@Entity
@Table(name = "rubrics")
@Data
public class Rubric {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @OneToMany(mappedBy = "rubric", fetch = FetchType.LAZY)
    private List<CompanyEntity> companies;
}
