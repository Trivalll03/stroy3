package com.thedeveloper.gnext.repository;

import com.thedeveloper.gnext.domain.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    List<Category> findAllByVisibleTrue();
}
