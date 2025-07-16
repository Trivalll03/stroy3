package com.thedeveloper.gnext.repository;

import com.thedeveloper.gnext.entity.ChatEntity;
import com.thedeveloper.gnext.entity.MessageEntity;
import com.thedeveloper.gnext.entity.UserEntity;
import org.springframework.data.domain.Limit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<MessageEntity, Long> {
    List<MessageEntity> findTop30MessageEntitiesByChatOrderByTimeDesc(ChatEntity chat);
    @Query(
            value = "SELECT * FROM messages WHERE DATE_ADD(messages.time,interval 2 day) < NOW();",
            nativeQuery = true)
    List<MessageEntity> findAfterTwoDays();
}
