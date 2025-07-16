package com.thedeveloper.gnext.service;

import com.thedeveloper.gnext.domain.Category;
import com.thedeveloper.gnext.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public List<Category> getVisibleCategories() {
        return categoryRepository.findAllByVisibleTrue();
    }

    public Category createCategory(Category category) {
        return categoryRepository.save(category);
    }
}
