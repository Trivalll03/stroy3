package com.thedeveloper.gnext.repository;

import com.thedeveloper.gnext.entity.CityEntity;
import com.thedeveloper.gnext.entity.UserEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserRepository extends CrudRepository<UserEntity, Long> {

    UserEntity findUserEntityByPhone(String phone);
    UserEntity findUserEntityByUid(String uid);

    boolean existsByPhone(String phone); // ✅ ВОТ ЭТО

    List<UserEntity> searchUserEntitiesByNameContaining(String name);
    List<UserEntity> searchUserEntitiesBySurnameContaining(String surname);
    List<UserEntity> searchUserEntitiesByPhoneContainingIgnoreCase(String phone);
    List<UserEntity> findUserEntitiesByCity(CityEntity city);

    @Query("SELECT u FROM UserEntity u WHERE u.createDate < CURRENT_DATE - 7")
    List<UserEntity> findAfterSevenDays();

    List<UserEntity> findAll();
}
