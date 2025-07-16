package com.thedeveloper.gnext.repository;

import com.thedeveloper.gnext.entity.Rubric;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import java.util.List;

public interface RubricRepository extends CrudRepository<Rubric, Long> {

    @Query("SELECT r FROM Rubric r")
    List<Rubric> findAllRubrics();
}
