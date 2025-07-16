package com.thedeveloper.gnext.controller;

import com.thedeveloper.gnext.entity.Rubric;
import com.thedeveloper.gnext.repository.RubricRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rubrics")
@RequiredArgsConstructor
public class RubricController {

    private final RubricRepository rubricRepository;

    @GetMapping
    public List<Rubric> getAllRubrics() {
        return rubricRepository.findAllRubrics();
    }

    @PostMapping
    public Rubric createRubric(@RequestBody Rubric rubric) {
        return rubricRepository.save(rubric);
    }
}
