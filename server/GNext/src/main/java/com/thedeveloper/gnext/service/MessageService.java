package com.thedeveloper.gnext.service;

import com.thedeveloper.gnext.entity.ChatEntity;
import com.thedeveloper.gnext.entity.MessageEntity;
import com.thedeveloper.gnext.entity.UserEntity;
import com.thedeveloper.gnext.enums.ChatMode;
import com.thedeveloper.gnext.repository.MessageRepository;
import com.thedeveloper.gnext.utils.NotificationService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
public class MessageService {
    MessageRepository repository;
    UserService userService;
    NotificationService notificationService;
    public List<MessageEntity> findMessagesByChat(ChatEntity chat){
        return repository.findTop30MessageEntitiesByChatOrderByTimeDesc(chat);
    }
    public void save(MessageEntity message){
        repository.save(message);
        if(message.getChat().getMode() != ChatMode.PRIVATE){
            List<UserEntity> users = userService.findByCity(message.getChat().getCity());
            for(UserEntity user : users){
              if(!Objects.equals(user.getId(), message.getUser().getId())){
                  notificationService.sendNotification(user, message.getChat());
              }

            }
        }
    }
    public List<MessageEntity> findAll(){
        return repository.findAll();
    }
    public void delete(MessageEntity message){
        repository.delete(message);
    }
    public List<MessageEntity> findAfterTwoDays(){
        return repository.findAfterTwoDays();
    }
}
